class ChangeForeignKeyToReviews < ActiveRecord::Migration[5.2]
  def change
    remove_reference :reviews, :booking, foreign_key: true
    add_reference :reviews, :ride, foreign_key: true
    add_reference :reviews, :user, foreign_key: true
  end
end
