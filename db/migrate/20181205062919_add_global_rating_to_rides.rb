class AddGlobalRatingToRides < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :global_rating, :integer, default: 0
  end
end
