class ChangeAirportsNameToLocation < ActiveRecord::Migration[6.0]
  def change
    remove_column :airports, :name 
    add_column :airports, :location, :string
  end
end
