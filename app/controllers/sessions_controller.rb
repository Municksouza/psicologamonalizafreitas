class SessionsController < Devise::SessionsController
  after_action :broadcast_online_status, only: :create
  after_action :broadcast_offline_status, only: :destroy
  

  private

  def broadcast_online_status
    if current_psychologist
      ActionCable.server.broadcast "online_status_channel",
                                   user: current_psychologist.email,
                                   status: "online"
    elsif current_patient
      ActionCable.server.broadcast "online_status_channel",
                                   user: current_patient.email,
                                   status: "online"
    end
  end

  def broadcast_offline_status
    if current_psychologist
      ActionCable.server.broadcast "online_status_channel",
                                   user: current_psychologist.email,
                                   status: "offline"
    elsif current_patient
      ActionCable.server.broadcast "online_status_channel",
                                   user: current_patient.email,
                                   status: "offline"
    end
  end
end
