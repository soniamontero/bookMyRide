class AddPhotoToBikes < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :photo, :string
  end
end
