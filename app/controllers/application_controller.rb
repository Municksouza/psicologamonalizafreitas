class ApplicationController < ActionController::Base
  helper_method :current_patient, :current_psychologist, :patient_signed_in?, :psychologist_signed_in?

  private

  def update_online_status
    if patient_signed_in?
      current_patient.update(online: true)
      ActionCable.server.broadcast "online_status_channel",
                                   { user: current_patient.email, status: "online" }
    elsif psychologist_signed_in?
      current_psychologist.update(online: true)
      ActionCable.server.broadcast "online_status_channel",
                                   { user: current_psychologist.email, status: "online" }
    end
  end

  def patient_signed_in?
    current_patient.present?
  end

  def psychologist_signed_in?
    current_psychologist.present?
  end

  def after_sign_out_path_for(resource_or_scope)
    Rails.logger.debug "Redirecionando após logout para: #{root_path}"
    root_path
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Patient)
      profile_patient_path(resource) # redireciona para o perfil do paciente
    elsif resource.is_a?(Psychologist)
      profile_psychologist_path(resource) # redireciona para o perfil do psicólogo
    else
      super # redireciona para o caminho padrão
    end
  end
end
