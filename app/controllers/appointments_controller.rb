class AppointmentsController < ApplicationController
  before_action :authenticate_psychologist!, only: [ :edit, :update, :destroy ]
  before_action :authenticate_patient!, only: [ :new, :create, :cancel, :book ]
  before_action :set_appointment, only: [ :edit, :update, :destroy, :cancel, :book ]

  def index
    if psychologist_signed_in?
      @appointments = current_psychologist.appointments
    elsif patient_signed_in?
      @available_appointments = Appointment.available.where("start_time >= ?", Time.zone.now)
      @booked_appointments = Appointment.booked.where(patient_id: current_patient.id)
      @completed_appointments = current_patient.appointments.where(status: "completed")

    end
  end

  def new
    @appointment = Appointment.new
    @available_dates = Appointment.where(status: "available").pluck(:start_time)
    @booked_dates = Appointment.where(status: "booked").pluck(:start_time)
  end



  def create
    Rails.logger.debug "Appointment Params: #{appointment_params}"

    if current_patient
      start_time_param = appointment_params[:start_time]

      Rails.logger.debug "Start Time Param: #{start_time_param}"

      @appointment = Appointment.find_by(start_time: start_time_param, status: "available")

      if @appointment && @appointment.update(patient: current_patient, status: "booked")
        redirect_to profile_patient_path(current_patient), notice: "Consulta marcada com sucesso!"
      else
        redirect_to new_patient_appointment_path(patient_id: current_patient.id), alert: "Este horário não está disponível."
      end
    elsif current_psychologist
      @appointment = current_psychologist.appointments.new(appointment_params)
      @appointment.status = "available"

      if @appointment.save
        redirect_to profile_psychologist_path(current_psychologist), notice: "Disponibilidade de consulta criada com sucesso!"
      else
        render :new, alert: "Erro ao criar a disponibilidade de consulta."
      end
    end
  end


  def book
    @appointment = Appointment.find(params[:id])

    if @appointment.available?
      @appointment.update(patient: current_patient, status: "booked")
      redirect_to patient_appointments_path(current_patient), notice: "Consulta marcada com sucesso!"
    else
      redirect_to new_patient_appointment_path, alert: "Este horário já está reservado."
    end
  end

  def cancel
    @appointment = Appointment.find(params[:id])

    if @appointment.patient == current_patient
      @appointment.update(patient: nil, status: "available")
      redirect_to patient_appointments_path(current_patient), notice: "Consulta cancelada com sucesso!"
    else
      redirect_to appointments_path, alert: "Você não tem autorização para cancelar esta consulta."
    end
  end

  def update
    if psychologist_signed_in?
      if @appointment.update(appointment_params)
        redirect_to appointments_path, notice: "Consulta atualizada com sucesso!"
      else
        render :edit, alert: "Erro ao atualizar a consulta."
      end
    else
      redirect_to root_path, alert: "Acesso negado."
    end
  end

  def destroy
    if psychologist_signed_in? && @appointment.psychologist == current_psychologist
      @appointment.destroy
      redirect_to appointments_path, notice: "Consulta excluída com sucesso."
    else
      redirect_to appointments_path, alert: "Você não tem permissão para excluir essa consulta."
    end
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:start_time, :end_time)
  end
end
