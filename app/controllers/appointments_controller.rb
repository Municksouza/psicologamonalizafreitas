class AppointmentsController < ApplicationController
  before_action :authenticate_psychologist!, only: [ :edit, :update, :destroy, :create ]
  before_action :authenticate_patient!, only: [ :new, :create, :update, :cancel, :book ]
  before_action :set_appointment, only: [ :edit, :update, :destroy, :cancel, :book ]
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  before_action :set_csrf_cookie_for_ng

  # Fetch appointments for FullCalendar in JSON format
  def index_json
    @appointments = Appointment.where("start_time >= ? AND end_time <= ?", params[:start], params[:end])

    render json: @appointments.map { |appointment|
      {
        id: appointment.id,
        title: appointment.patient ? "#{appointment.patient.full_name}" : "Available",
        start: appointment.start_time.iso8601,
        end: appointment.end_time.iso8601,
        status: appointment.status,
        color: appointment.patient ? "#ff9f89" : "#3a87ad"  # Corrected quotes
      }
    }
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
    if current_patient
      # Booking an available appointment
      if @appointment.status == "available" && @appointment.patient.nil?
        if @appointment.update(patient: current_patient, status: "booked")
          respond_to do |format|
            format.json { render json: { message: "Appointment booked successfully!" }, status: :ok }
            format.html { redirect_to patient_appointments_path(current_patient), notice: "Appointment booked successfully!" }
          end
        else
          respond_to do |format|
            format.json { render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity }
            format.html { render :new }
          end
        end
      else
        respond_to do |format|
          format.json { render json: { error: "This appointment is no longer available." }, status: :unprocessable_entity }
          format.html { redirect_to new_patient_appointment_path, alert: "This appointment is no longer available." }
        end
      end
    end
  end

  # Cancel action for patients to cancel their appointment
  def cancel
    if current_patient == @appointment.patient
      @appointment.update(patient: nil, status: "available")
      respond_to do |format|
        format.json { render json: { message: "Appointment canceled successfully." }, status: :ok }
        format.html { redirect_to patient_appointments_path(current_patient), notice: "Appointment canceled successfully." }
      end
    else
      respond_to do |format|
        format.json { render json: { error: "You are not authorized to cancel this appointment." }, status: :unauthorized }
        format.html { redirect_to patient_appointments_path(current_patient), alert: "You are not authorized to cancel this appointment." }
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
