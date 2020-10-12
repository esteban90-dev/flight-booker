class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
  end

  def new
    if params[:booking][:flight].nil?
      flash[:notice] = "A flight must be selected before submitting"
      redirect_to root_path
    else
      @booking = Booking.new
      @booking.flight = Flight.find(params[:booking][:flight])
      passenger_count.times{ @booking.passengers.build }
    end
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      flash[:notice] = "Flight has been successfully booked!"
      redirect_to booking_path(@booking)
      reset_session
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
