class MessagesController < ApplicationController
  before_action :authenticate_psychologist!, only: [ :create, :destroy ]
  before_action :authenticate_patient!, only: [ :create, :destroy ]

  def create
    @message = current_psychologist.messages.new(message_params)
    if @message.save
      ActionCable.server.broadcast "messages_#{@message.patient_id}",
                                   sender: current_psychologist.email,
                                   content: @message.content
      redirect_to patient_messages_path(current_patient), notice: "Message sent successfully."
    else
      render "index"
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to patient_messages_path(current_patient), notice: "Message deleted."
  end

  private

  def message_params
    params.require(:message).permit(:content, :patient_id)
  end
end
