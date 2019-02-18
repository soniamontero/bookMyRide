class AddCoordinatesToRides < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :latitude, :float
    add_column :rides, :longitude, :float
  end
end
