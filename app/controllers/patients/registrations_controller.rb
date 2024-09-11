class Patients::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [ :create ]
  before_action :configure_account_update_params, only: [ :update ]


  # Sobrescrevendo o método Devise para permitir campos personalizados durante o cadastro
  def sign_up_params
    params.require(:patient).permit(:email, :password, :phone_number, :password_confirmation, :full_name, :address, :date_of_birth, :photo)
  end

  # Sobrescrevendo o método Devise para permitir campos personalizados durante a atualização de conta
  def account_update_params
    params.require(:patient).permit(:email, :password, :password_confirmation, :current_password, :full_name, :address, :date_of_birth, :photo)
  end

  private

  # Permitir parâmetros adicionais durante o cadastro
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :email, :password, :password_confirmation, :full_name, :phone_number, :address, :date_of_birth, :photo ])
  end

  # Permitir parâmetros adicionais durante a atualização de conta
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [ :full_name, :address, :date_of_birth, :photo ])
  end
end
