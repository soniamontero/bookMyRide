class AddIsOverToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :is_over, :boolean, default: false
  end
end
