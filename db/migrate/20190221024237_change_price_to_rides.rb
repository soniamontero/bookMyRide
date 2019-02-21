class ChangePriceToRides < ActiveRecord::Migration[5.2]
  def change
    change_table :rides do |t|
      t.monetize :price # Rails 4x and above
    end
  end
end
