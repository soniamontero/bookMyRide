class RenameTypeToCategory < ActiveRecord::Migration[5.2]
  def change
    rename_column :rides, :type, :category
  end
end
