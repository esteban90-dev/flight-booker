class BookingsController < ApplicationController
  def new
    @flight = Flight.find(params[:booking][:flight])
    @booking = Booking.new
    @booking.passengers.build
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      render plain: "Worked!"
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: [ :id, :name, :email ])
  end
end
