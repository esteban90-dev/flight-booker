class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
    @booking.flight = Flight.find(params[:booking][:flight])
    passenger_count.times{ @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: [ :id, :name, :email ])
  end

  def passenger_count
    params[:booking][:passengers].to_i
  end
end
