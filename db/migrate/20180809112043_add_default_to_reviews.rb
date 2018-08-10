class AddDefaultToReviews < ActiveRecord::Migration[5.2]
  def change
    change_column :reviews, :like, :integer, default: 0
  end
end
