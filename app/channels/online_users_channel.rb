class OnlineUsersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "online_users"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
