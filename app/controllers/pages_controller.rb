class PagesController < ApplicationController
  before_action :authenticate_patient_or_psychologist!, only: [ :index ]  # Ensure only logged-in users can access the index

  def home
    if psychologist_signed_in?
      @appointments = current_psychologist.appointments
      if patient_signed_in?
        @booked_appointments = Appointment.booked.where(patient_id: current_patient.id)
      end
    else
      @appointments = [] # Empty array to avoid nil errors in the view
    end
    @testimonials = Testimonial.all.order(created_at: :desc)
    Rails.logger.debug "Type of @appointments: #{@appointments.class}"
    Rails.logger.debug "@appointments content: #{@appointments.inspect}"
  end

  def index
    @testimonials = Testimonial.all  # Fetch all testimonials for display

    # You can use current_patient or current_psychologist directly
    if patient_signed_in?
      # Logic specific to patients can be added here
      # e.g., @patient = current_patient
    elsif psychologist_signed_in?
      # Logic specific to psychologists can be added here
      # e.g., @psychologist = current_psychologist
    end
  end

  def signup_page
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :email, :password, :password_confirmation, :full_name, :phone_number, :address, :date_of_birth, :photo ])
  end


  private

  def authenticate_patient_or_psychologist!
    unless patient_signed_in? || psychologist_signed_in?
      redirect_to new_patient_session_path
    end
  end
end
