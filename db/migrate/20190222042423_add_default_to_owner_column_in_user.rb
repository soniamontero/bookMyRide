class AddDefaultToOwnerColumnInUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :owner, :boolean, default: true
  end
end
