class AddLatLonToAirports < ActiveRecord::Migration[6.0]
  def change
    add_column :airports, :latitude, :float
    add_column :airports, :longitude, :float
  end
end
