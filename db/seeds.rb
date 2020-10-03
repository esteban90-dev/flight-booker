# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AIRPORTS = [
  { code: "ATL",
    location: "Atlanta",
    latitude: 33.6407,
    longitude: -84.4277 },

  { code: "PEK",
    location: "Beijing",
    latitude: 40.0799,
    longitude: 116.6031 },

  { code: "LAX",
    location: "Los Angeles",
    latitude: 33.9416,
    longitude: -118.4085 },

  { code: "DXB",
    location: "Dubai",
    latitude: 25.2048,
    longitude: 55.2708 },

  { code: "HND",
    location: "Tokyo",
    latitude: 35.5494,
    longitude: 139.7798 },

  { code: "ORD",
    location: "Chicago",
    latitude: 41.9742,
    longitude: -87.9073 },

  { code: "LHR",
    location: "London",
    latitude: 51.4700,
    longitude: -0.4543 },

  { code: "PVG",
    location: "Shanghai",
    latitude: 31.1443,
    longitude: 121.8083 },

  { code: "CDG",
    location: "Paris",
    latitude: 49.0139,
    longitude: 2.5425 },

  { code: "DFW",
    location: "Washington D.C.",
    latitude: 32.897480,
    longitude: -97.040443 }
]

#Generate Airports

airports = AIRPORTS.map do |airport|
  Airport.create(airport)
end


#Generate Flights

END_DATE = Time.new(2020,12,31).to_f
START_DATE = Time.new(2020,1,1).to_f
FLIGHT_SPEED = 500 #mph

def random_datetime
  Time.at(( (END_DATE - START_DATE) * rand() ) + START_DATE )
end


1000.times do 
  from_airport = airports.sample
  to_airport = ""
  

  loop do
    to_airport = airports.sample
    break if to_airport != from_airport
  end

  distance = Haversine.distance(from_airport.latitude, from_airport.longitude, to_airport.latitude, to_airport.longitude).to_miles
  duration = distance / FLIGHT_SPEED

  flight_params = {
    from_airport: from_airport,
    to_airport: to_airport,
    duration: duration,
    datetime: random_datetime
  }

  Flight.create(flight_params)
end

