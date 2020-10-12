class FlightsController < ApplicationController
  before_action :set_flight, only: [:show]
  before_action :store_search_terms
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

  def store_search_terms
    if params[:search]
      session[:from_airport] = params[:search][:from_airport]
      session[:to_airport] = params[:search][:to_airport]
      session[:passenger_number] = params[:search][:passenger_number]
      session[:date] = params[:search][:date]
    end
  end
end
