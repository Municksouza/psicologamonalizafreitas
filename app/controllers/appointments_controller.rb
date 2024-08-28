class AppointmentsController < ApplicationController
  before_action :authenticate_psychologist!, only: [ :edit, :update, :destroy, :new, :create ]
  before_action :authenticate_patient!, only: [ :index ]

  def index
    if psychologist_signed_in?
      @appointments = current_psychologist.appointments
    elsif patient_signed_in?
      @appointments = current_patient.appointments
    end
  end

  def new
    @appointment = current_psychologist.appointments.new
  end

  def create
    @appointment = current_psychologist.appointments.new(appointment_params)
    if @appointment.save
      redirect_to appointments_path, notice: "Appointment created successfully."
    else
      render :new
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_params)
      redirect_to appointments_path, notice: "Appointment updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    redirect_to appointments_path, notice: "Appointment deleted successfully."
  end

  private

  def appointment_params
    params.require(:appointment).permit(:date, :patient_id)
  end
end
