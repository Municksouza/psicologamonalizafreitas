class Psychologists::SessionsController < Devise::RegistrationsController
  before_action :authenticate_psychologist!, only: [ :destroy ]

  def after_sign_in_path_for(resource)
    profile_psychologist_path(resource)
  end

  def after_sign_out_path_for(resource_or_scope)
    # Redireciona após o logout
    root_path
  end
end
