class AddPriceToRides < ActiveRecord::Migration[5.2]
  def change
    remove_column :rides, :price
    add_monetize :rides, :price, currency: { present: false }
  end
end
