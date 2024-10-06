class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
  def new_booking_email
    @appointment = params[:appointment]
    mail(to: @appointment.psychologist.email, subject: "Nova consulta marcada")
  end
end
