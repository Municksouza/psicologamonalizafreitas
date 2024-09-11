class Patients::SessionsController < Devise::SessionsController
  def new
    Rails.logger.debug "Devise mapping: #{Devise.mappings[:patient]}"
    super
  end
end
