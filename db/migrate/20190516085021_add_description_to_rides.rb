class AddDescriptionToRides < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :description, :text
  end
end
