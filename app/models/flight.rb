class Flight < ApplicationRecord
  belongs_to :from_airport, class_name: "Airport"
  belongs_to :to_airport, class_name: "Airport"

  def self.by_date(date)
    date_range = date.beginning_of_day..date.end_of_day
    where(datetime: date_range)
  end

  def self.by_from_airport(airport)
    where(from_airport: airport)
  end

  def self.by_to_airport(airport)
    where(to_airport: airport)
  end
end
