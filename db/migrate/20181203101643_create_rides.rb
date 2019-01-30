class CreateRides < ActiveRecord::Migration[5.2]
  def change
    create_table :rides do |t|
      t.string :name
      t.string :type
      t.integer :year
      t.integer :price
      t.string :location

      t.timestamps
    end
  end
end
