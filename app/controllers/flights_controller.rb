class FlightsController < ApplicationController
  before_action :set_flight, only: [:show]
  before_action :airport_options, only: [:index]

  def index
    if params[:search]
      if date_not_selected?
        flash[:notice] = "You must pick a date"
        redirect_to root_path
      else
        @flights = Flight.by_date(selected_date)
        @flights = @flights.by_from_airport(params[:search][:from_airport])
        @flights = @flights.by_to_airport(params[:search][:to_airport])
        search_values
      end
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

  def date_not_selected?
    params[:search][:date].empty?
  end

  def selected_date
    Date.parse(params[:search][:date])
  end

  def search_values
    @from_airport = params[:search][:from_airport]
    @to_airport = params[:search][:to_airport]
    @passenger_number = params[:search][:passenger_number]
    @date = selected_date
  end
end
