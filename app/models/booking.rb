class Booking < ApplicationRecord
  belongs_to :flight
  has_many :passengers

  accepts_nested_attributes_for :passengers

  before_save :find_existing_passengers

  private

  def find_existing_passengers
    self.passengers = self.passengers.map do |passenger|
      existing_passenger = Passenger.find_by(name: passenger.name, email: passenger.email)
      if existing_passenger
        existing_passenger 
      else
        passenger
      end
    end
  end
end
