class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_patient, :current_psychologist, :patient_signed_in?, :psychologist_signed_in?
  before_action :log_current_user
  before_action :check_warden
  after_action :update_online_status, if: :user_signed_in?

  # Log de informações sobre o Warden e usuários autenticados
  def check_warden
    Rails.logger.debug "Warden user: #{warden.user.inspect}"
    if patient_signed_in?
      Rails.logger.debug "Warden authenticate (patient): #{current_patient.email}"
    elsif psychologist_signed_in?
      Rails.logger.debug "Warden authenticate (psychologist): #{current_psychologist.email}"
    else
      Rails.logger.debug "Nenhum usuário autenticado."
    end
  end

  private

  # Atualiza o status online para o paciente ou psicólogo e notifica via ActionCable
  def update_online_status
    if patient_signed_in?
      current_patient.update(online: true)
      ActionCable.server.broadcast "online_status_channel", { user: current_patient.email, status: "online" }
    elsif psychologist_signed_in?
      current_psychologist.update(online: true)
      ActionCable.server.broadcast "online_status_channel", { user: current_psychologist.email, status: "online" }
    end
  end

  # Verifica se qualquer tipo de usuário está logado
  def user_signed_in?
    patient_signed_in? || psychologist_signed_in?
  end

  # Define se o paciente está logado
  def patient_signed_in?
    current_patient.present?
  end

  # Define se o psicólogo está logado
  def psychologist_signed_in?
    current_psychologist.present?
  end

  # Caminho após sign out
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :patient
      new_patient_session_path  # Redirecionar para o login do paciente
    elsif resource_or_scope == :psychologist
      new_psychologist_session_path  # Redirecionar para o login do psicólogo
    else
      root_path
    end
  end

  # Caminho após sign in
  def after_sign_in_path_for(resource)
    if resource.is_a?(Patient)
      profile_patient_path(resource)  # Redirecionar para o perfil do paciente
    elsif resource.is_a?(Psychologist)
      profile_psychologist_path(resource)  # Redirecionar para o perfil do psicólogo
    else
      super
    end
  end

  protected

  # Permitir parâmetros adicionais de Devise (full_name, address, phone_number, etc.)
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :address, :phone_number, :date_of_birth, :photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :address, :phone_number, :date_of_birth, :photo])
  end

  # Log para rastrear o paciente ou psicólogo atual
  def log_current_user
    Rails.logger.debug "Current Patient: #{current_patient.inspect}"
    Rails.logger.debug "Current Psychologist: #{current_psychologist.inspect}"
  end
end
