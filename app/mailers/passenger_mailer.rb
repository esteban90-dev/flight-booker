class PassengerMailer < ApplicationMailer
  default from: "notifications@example.com"

  def confirmation_email
    @passenger = params[:passenger]
    @booking = params[:booking]
    mail(to: @passenger.email, subject: "Flight Successfully Booked")
  end
end
