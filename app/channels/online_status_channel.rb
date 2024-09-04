class OnlineStatusChannel < ApplicationCable::Channel
  def subscribed
    stream_from "online_status_channel"
  end

  def unsubscribed
    # Cleanup when channel is unsubscribed
  end
end
