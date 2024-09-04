class Patients::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]


  def sign_up_params
    params.require(:patient).permit(:email, :password, :password_confirmation, :full_name, :address, :date_of_birth, :photo)
  end

  def account_update_params
    params.require(:patient).permit(:email, :password, :password_confirmation, :current_password, :full_name, :address, :date_of_birth, :photo)
  end
end

def configure_sign_up_params
  devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :full_name, :address, :date_of_birth, :photo])
end

def configure_account_update_params
  devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :address, :date_of_birth, :photo])
end
