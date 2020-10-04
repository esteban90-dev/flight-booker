class FlightsController < ApplicationController
  before_action :set_flight, only: [:show]
  before_action :airport_options, only: [:index]

  def index
    if params[:search]
      @flights = Flight.by_date(selected_date)
      @flights = @flights.by_from_airport(search_params[:from_airport])
      @flights = @flights.by_to_airport(search_params[:to_airport])
      @search = search_params
      binding.pry
    else
      @flights = Flight.take(5)
      @search = nil_search_params
    end
  end

  private

  def set_flight
    @flight = Flight.find(params(:id))
  end

  def airport_options
    @airport_options = Airport.all.map { |airport| [ airport.location, airport.id ] }
  end

  def search_params
    params.require(:search).permit(:from_airport, :to_airport, :passenger_number, :date)
  end

  def selected_date
    Date.new(search_params["date(1i)"].to_i,
             search_params["date(2i)"].to_i,
             search_params["date(3i)"].to_i).beginning_of_day
  end

  def nil_search_params
    {
      from_airport: nil,
      to_airport: nil,
      passenger_number: nil,
      date: nil
    }
  end



end
