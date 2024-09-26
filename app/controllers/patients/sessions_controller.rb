class Patients::SessionsController < Devise::SessionsController
  def new
    Rails.logger.debug "Devise mapping: #{Devise.mappings[:patient]}"
    super
  end

  def after_sign_in_path_for(resource)
    profile_patient_path(resource)
  end
end
