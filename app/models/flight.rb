class Flight < ApplicationRecord
  belongs_to :from_airport, class_name: "Airport"
  belongs_to :to_airport, class_name: "Airport"

  has_many :bookings, dependent: :destroy
  has_many :passengers, through: :bookings

  def self.by_date(date)
    date_range = date.beginning_of_day..date.end_of_day
    where(datetime: date_range)
  end

  def self.by_from_airport(airport)
    if airport.empty?
      all
    else
      where(from_airport: airport)
    end
  end

  def self.by_to_airport(airport)
    if airport.empty?
      all
    else
      where(to_airport: airport)
    end
  end
end
