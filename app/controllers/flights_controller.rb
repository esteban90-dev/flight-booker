class FlightsController < ApplicationController
  before_action :set_flight, only: [:show]
  before_action :airport_options, only: [:index]

  def index
    if params[:search]
      if params[:search][:date].empty?
        flash[:notice] = "You must pick a date"
        redirect_to root_path
      else
        @flights = Flight.by_date(selected_date)
        @flights = @flights.by_from_airport(search_params[:from_airport])
        @flights = @flights.by_to_airport(search_params[:to_airport])
      end
    end
    search_values
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
    Date.parse(search_params[:date])
  end

  def check_for_date
    if params[:search][:date].empty?
      flash[:notice] = "You must pick a date"
      redirect_to root_path
    end
  end

  def search_values
    if params[:search]
      @from_airport = search_params[:from_airport]
      @to_airport = search_params[:to_airport]
      @passenger_number = search_params[:passenger_number]
      @date = search_params[:date]
    else
      @from_airport = nil
      @to_airport = nil
      @passenger_number = nil
      @date = Date.today
    end
  end
end
