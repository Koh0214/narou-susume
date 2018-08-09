class AddNovelRefToReviews < ActiveRecord::Migration[5.2]
  def change
    add_reference :reviews, :novel, foreign_key: true
  end
end
