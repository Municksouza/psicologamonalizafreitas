class AppointmentsController < ApplicationController
  before_action :authenticate_psychologist!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_patient!, only: [:index, :show, :book, :cancel]
  before_action :authenticate_any!, only: [:accept, :decline] # Authenticate any user for accepting/declining
  before_action :set_appointment, only: [:show, :edit, :update, :destroy, :book, :cancel]

  def index
    if psychologist_signed_in?
      @appointments = current_psychologist.appointments
    elsif patient_signed_in?
      @appointments = Appointment.where(status: 'available').or(Appointment.where(patient_id: current_patient.id))
    end
  end

  def accept
    @appointment.update(status: 'accepted')
    redirect_to appointments_path, notice: "Appointment accepted successfully."
  end

  def decline
    @appointment.update(status: 'declined')
    redirect_to appointments_path, notice: "Appointment declined successfully."
  end

  def show
    # Shows appointment details
  end

  def new
    @appointment = current_psychologist.appointments.new
  end

  def create
    # Psychologist creating an available appointment slot
    @appointment = current_psychologist.appointments.new(appointment_params)
    if @appointment.save
      redirect_to psychologist_path(current_psychologist), notice: "Appointment slot created successfully."
    else
      render :new
    end
  end

  def book
    if @appointment.update(status: 'booked', patient: current_patient)
      redirect_to appointments_path, notice: 'Consulta marcada com sucesso.'
    else
      redirect_to appointments_path, alert: 'Não foi possível marcar a consulta.'
    end
  end

  def edit
    # Edit appointment details
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to appointments_path, notice: "Appointment updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_path, notice: "Appointment deleted successfully."
  end

  def cancel
    @appointment.update(status: 'canceled', patient: nil)
    redirect_to appointments_path, notice: "Appointment canceled successfully."
  end

  private

  def appointment_params
    params.require(:appointment).permit(:start_time, :end_time, :details)
  end

  def authenticate_any!
    authenticate_patient! || authenticate_psychologist!
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end
end
