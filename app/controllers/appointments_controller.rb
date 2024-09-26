class AppointmentsController < ApplicationController
  before_action :authenticate_psychologist!, only: [ :edit, :update, :destroy, :create ]
  before_action :authenticate_patient!, only: [ :new, :update, :cancel, :book ]
  before_action :set_appointment, only: [ :show, :edit, :update, :destroy, :cancel, :book ]
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  before_action :set_csrf_cookie_for_ng


# Ensure @appointment is initialized before rendering the index
  def index
    if psychologist_signed_in?
      @appointments = current_psychologist.appointments
      @appointment = Appointment.new  # Initialize for psychologist
    elsif patient_signed_in?
      @appointments = Appointment.where(status: 'available')  # Fetch only available appointments for patients
      @appointment = Appointment.new  # Initialize for patient booking
    else
      @appointments = []
    end
  end

  def new
    if current_psychologist
      # Psychologist is creating a new appointment
      @appointment = Appointment.new
    elsif current_patient
      # Fetch available appointments for the patient
      available_appointments = Appointment.where(status: 'available')

      if available_appointments.exists?
        # Get the first available appointment for the patient to book
        @appointment = available_appointments.first
      else
        # Initialize a new appointment if none available (or handle accordingly)
        @appointment = Appointment.new
        flash[:alert] = "No available appointments at the moment."
      end
    end
  end


  # Create action (handles both booking and slot creation)
  def create
    if current_psychologist
      # Creating a new appointment slot by a psychologist
      @appointment = current_psychologist.appointments.new(appointment_params)
      @appointment.status = "available"  # Mark it as available

      if @appointment.save
        render json: @appointment, status: :created
      else
        render json: @appointment.errors, status: :unprocessable_entity
      end
    end
  end

  # Method to allow patients to book available appointments
  def book
    @appointment = Appointment.find(params[:id])
    if @appointment.status == "available" && @appointment.patient.nil?
      @appointment.update(patient: current_patient, status: "booked")
      redirect_to patient_appointments_path(current_patient), notice: "Consulta marcada com sucesso!"
    else
      redirect_to new_patient_appointment_path, alert: "Este horário não está disponível."
    end
  end


  # Cancel action for patients to cancel their appointment
  def cancel
    if current_patient == @appointment.patient
      @appointment.update(patient: nil, status: "available")
      respond_to do |format|
        format.json { render json: { message: "Consulta cancelada com sucesso!" }, status: :ok }
        format.html { redirect_to patient_appointments_path(current_patient), notice: "Consulta cancelada com sucesso!" }
      end
    else
      respond_to do |format|
        format.json { render json: { error: "Você não tem autorização para cancelar esta consulta." }, status: :unauthorized }
        format.html { redirect_to patient_appointments_path(current_patient), alert: "Você não tem autorização para cancelar esta consulta." }
      end
    end
  end

  # Edit and update action for psychologists
  def edit
    if psychologist_signed_in?
      # Psychologist can edit the appointment
    else
      redirect_to root_path, alert: "Access denied"
    end
  end

  def update
    if psychologist_signed_in?
      if @appointment.update(appointment_params)
        respond_to do |format|
          format.json { render json: { message: "Appointment updated successfully." }, status: :ok }
          format.html { redirect_to appointments_path, notice: "Appointment updated successfully." }
        end
      else
        respond_to do |format|
          format.json { render json: @appointment.errors, status: :unprocessable_entity }
          format.html { render :edit }
        end
      end
    end
  end

  # Destroy action for psychologists to delete appointment slots
  def destroy
    if current_psychologist == @appointment.psychologist
      @appointment.destroy
      render json: { message: "Appointment slot deleted successfully." }, status: :ok
    else
      render json: { error: "You are not authorized to delete this appointment slot." }, status: :unauthorized
    end
  end

  def show
    @appointment = Appointment.find(params[:id])  # Ensure @appointment is set
    if @appointment.psychologist
      render :show
    else
      redirect_to appointments_path, alert: 'Psychologist not found for this appointment.'
    end
  end


  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:start_time, :end_time)
  end

  def set_csrf_cookie_for_ng
    cookies["CSRF-TOKEN"] = form_authenticity_token if protect_against_forgery?
  end
end
