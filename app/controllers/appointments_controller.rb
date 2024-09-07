class AppointmentsController < ApplicationController
  before_action :authenticate_psychologist!, only: [:edit, :update, :destroy]
  before_action :authenticate_patient!, only: [:new, :create, :update, :cancel] # Patients book and update

  before_action :set_patient_or_psychologist, only: [:create, :update] # Set current user based on role
  before_action :set_appointment, only: [:show, :edit, :update, :destroy, :cancel]
  before_action :check_psychologist_permissions, only: [:edit, :update, :destroy]
  before_action :check_patient_permissions, only: [:edit, :update, :destroy]

  def index_json
    Rails.logger.debug "Params: #{params.inspect}"  # Log the parameters received

    start_date = params[:start] || Date.today.beginning_of_month.to_s
    end_date = params[:end] || Date.today.end_of_month.to_s

    @appointments = Appointment.where('start_time >= ? AND end_time <= ?', start_date, end_date)
    Rails.logger.debug "Found appointments: #{@appointments.count}"

    render json: @appointments.map { |appointment|
      {
        id: appointment.id,
        title: "#{appointment.patient&.full_name} - #{appointment.psychologist&.full_name}",
        start: appointment.start_time.iso8601,
        end: appointment.end_time.iso8601,
        url: appointments_json_path(appointment)
      }
    }
  end


  def index
    if psychologist_signed_in?
      @appointments = current_psychologist.appointments
    elsif patient_signed_in?
      @available_appointments = Appointment.where(status: 'available', patient_id: nil)
      @booked_appointments = current_patient.appointments # Fetch booked appointments for the current patient
      @appointment = Appointment.new # Initialize @appointment for form usage
    end
  end

  def new
    if patient_signed_in?
      @available_appointments = Appointment.where(status: 'available', patient_id: nil)
      if @available_appointments.empty?
        redirect_to patient_appointments_path, alert: 'No available appointments to book at the moment.'
      else
        @appointment = Appointment.new # Initialize a new appointment object for booking
      end
    elsif psychologist_signed_in?
      @appointment = Appointment.new
    else
      redirect_to new_patient_session_path, alert: 'You need to sign in to access this page.'
    end
  end

  def create
    if current_patient
      if params[:appointment_booking].present? && params[:appointment_booking][:appointment_id].present?
        @appointment = Appointment.find(params[:appointment_booking][:appointment_id])

        if @appointment.update(patient: current_patient, status: 'booked')
          redirect_to patient_appointments_path(current_patient), notice: 'Appointment successfully booked.'
        else
          render :new
        end
      else
        redirect_to new_patient_appointment_path, alert: 'Please select an available appointment.'
      end
    elsif current_psychologist
      @appointment = current_psychologist.appointments.new(appointment_params)
      if @appointment.save
        redirect_to psychologist_appointments_path, notice: 'Appointment slot successfully created.'
      else
        render :new
      end
    end
  end

  def update
    if patient_signed_in?
      if @appointment.update(patient: current_patient, status: 'booked')
        redirect_to appointments_path, notice: 'Appointment successfully booked.'
      else
        render :index
      end
    elsif psychologist_signed_in?
      if @appointment.update(appointment_params)
        redirect_to appointments_path, notice: 'Appointment successfully updated.'
      else
        render :edit
      end
    end
  end

  def destroy
    if psychologist_signed_in?
      @appointment.destroy
      redirect_to psychologist_appointments_path(current_psychologist), notice: 'Appointment deleted permanently.'
    else
      redirect_to root_path, alert: 'Only psychologists can delete appointments permanently.'
    end
  end

  def cancel
    if current_patient == @appointment.patient
      @appointment.update(patient: nil, status: 'available')
      redirect_to patient_appointments_path(current_patient), notice: 'You have canceled the appointment. It is now available for others.'
    else
      redirect_to patient_appointments_path(current_patient), alert: 'You are not authorized to cancel this appointment.'
    end
  end



  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def set_patient_or_psychologist
    @patient = current_patient if current_patient
    @psychologist = current_psychologist if current_psychologist
  end

  def appointment_params
    params.require(:appointment).permit(:start_time, :end_time, :details, :status)
  end

  def check_psychologist_permissions
    redirect_to(root_path, alert: 'Access denied') unless current_psychologist?
  end

  def check_patient_permissions
    if current_patient && @appointment.patient != current_patient
      redirect_to(root_path, alert: 'Access denied')
    end
  end
end
