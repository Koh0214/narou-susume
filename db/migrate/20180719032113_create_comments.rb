class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :name
      t.text :comment
      t.integer :up
      t.integer :down
      t.references :novel, foreign_key: true

      t.timestamps
    end
  end
end
