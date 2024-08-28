class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :set_online_status

  allow_browser versions: :modern

  private

  def set_online_status
    if current_psychologist
      ActionCable.server.broadcast "online_users",
                                   user: current_psychologist.email,
                                   status: "online"
    elsif current_patient
      ActionCable.server.broadcast "online_users",
                                   user: current_patient.email,
                                   status: "online"
    end
  end
end
