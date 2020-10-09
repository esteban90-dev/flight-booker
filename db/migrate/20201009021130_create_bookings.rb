class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :flight
      t.belongs_to :passenger
      t.timestamps
    end
  end
end
