class AddDateAddTimeRemoveDatetimeFromFlights < ActiveRecord::Migration[6.0]
  def change
    remove_column :flights, :datetime
    add_column :flights, :date, :date
    add_column :flights, :time, :time
  end
end
