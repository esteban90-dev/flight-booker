class AddDatetimeAndDurationToFlights < ActiveRecord::Migration[6.0]
  def change
    add_column :flights, :datetime, :datetime
    add_column :flights, :duration, :integer
  end
end
