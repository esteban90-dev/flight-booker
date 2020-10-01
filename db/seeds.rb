# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AIRPORTS = [
  { code: "ATL",
    location: "Atlanta" },
  { code: "PEK",
    location: "Beijing" },
  { code: "LAX",
    location: "Los Angeles" },
  { code: "DXB",
    location: "Dubai" },
  { code: "HND",
    location: "Tokyo" },
  { code: "ORD",
    location: "Chicago" },
  { code: "LHR",
    location: "London" },
  { code: "PVG",
    location: "Shanghai" },
  { code: "CDG",
    location: "Paris" },
  { code: "DFW",
    location: "Washington D.C."}
]

AIRPORTS.each do |airport|
  Airport.create(airport)
end