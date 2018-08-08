class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :name
      t.text :text
      t.integer :like

      t.timestamps
    end
  end
end
