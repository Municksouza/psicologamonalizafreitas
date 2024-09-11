class Psychologists::SessionsController < Devise::RegistrationsController
  before_action :authenticate_psychologist!, only: [ :destroy ]



  def after_sign_in_path_for(resource)
    # Redireciona após o login
    stored_location_for(resource) || root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    # Redireciona após o logout
    root_path
  end
end
