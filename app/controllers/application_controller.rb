class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_patient, :current_psychologist, :patient_signed_in?, :psychologist_signed_in?
  before_action :log_current_user
  before_action :check_warden

  def check_warden
    # Adding log to track which user is currently logged in
    Rails.logger.debug "Warden user: #{warden.user.inspect}"
    Rails.logger.debug "Warden authenticate (patient): #{warden.authenticate(scope: :patient)}"
    Rails.logger.debug "Warden authenticate (psychologist): #{warden.authenticate(scope: :psychologist)}"
  end

  private

  def update_online_status
    if patient_signed_in?
      current_patient.update(online: true)
      ActionCable.server.broadcast "online_status_channel", { user: current_patient.email, status: "online" }
    elsif psychologist_signed_in?
      current_psychologist.update(online: true)
      ActionCable.server.broadcast "online_status_channel", { user: current_psychologist.email, status: "online" }
    end
  end

  # Define whether the current user is a patient or psychologist
  def patient_signed_in?
    current_patient.present?
  end

  def psychologist_signed_in?
    current_psychologist.present?
  end

  # Ensure correct redirection after sign out
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :patient
      new_patient_session_path  # Redirect to patient login
    elsif resource_or_scope == :psychologist
      new_psychologist_session_path  # Redirect to psychologist login
    else
      root_path
    end
  end

  # Ensure correct redirection after sign in
  def after_sign_in_path_for(resource)
    if resource.is_a?(Patient)
      profile_patient_path(resource)
    elsif resource.is_a?(Psychologist)
      profile_psychologist_path(resource)
    else
      super
    end
  end


  protected

  # Permit additional Devise parameters for sign up and account update
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :address, :phone_number, :date_of_birth, :photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :address, :phone_number, :date_of_birth, :photo])
  end
end

def log_current_user
  Rails.logger.debug "Current Patient: #{current_patient.inspect}"
  Rails.logger.debug "Current Psychologist: #{current_psychologist.inspect}"
end
