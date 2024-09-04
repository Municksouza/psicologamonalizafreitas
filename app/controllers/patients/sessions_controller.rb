class Patients::SessionsController < Devise::SessionsController
  before_action :authenticate_patient!, only: [:destroy]
  def destroy
    super
    logger.debug  # Isso chama o método `destroy` padrão do Devise
    # Adicione qualquer lógica personalizada aqui, se necessário
  end

  def after_sign_in_path_for(resource)
    # Redireciona após o login
    stored_location_for(resource) || root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    logger.debug
    new_patient_session_path
    # Redireciona após o logout
 
  end
end
