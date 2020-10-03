class Flight < ApplicationRecord
  belongs_to :from_airport, class_name: "Airport"
  belongs_to :to_airport, class_name: "Airport"

  def self.by_date(date)
    date_range = date.beginning_of_day..date.end_of_day
    where(datetime: date_range)
  end
end
