class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
  end

  def new
    if params[:booking][:flight].nil?
      flash[:notice] = "A flight must be selected before submitting"
      redirect_to controller: "flights", action: "index", search: search_params
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
      send_confirmation_email
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

  def search_params
    { 
      from_airport: params[:booking][:from_airport],
      to_airport: params[:booking][:to_airport],
      passenger_number: params[:booking][:passengers],
      date: params[:booking][:date]
    }
  end
  
  def send_confirmation_email
    @booking.passengers.each do |passenger|
      PassengerMailer.with(passenger: passenger, booking: @booking).confirmation_email.deliver_now
    end
  end
end
