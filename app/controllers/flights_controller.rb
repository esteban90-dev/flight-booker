class FlightsController < ApplicationController
  before_action :set_flight, only: [:show]

  def index
    @flights = Flight.all 
  end

  private

  def set_flight
    @flight = Flight.find(params(:id))
  end
end
