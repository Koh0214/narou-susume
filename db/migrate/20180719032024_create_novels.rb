class CreateNovels < ActiveRecord::Migration[5.2]
  def change
    create_table :novels do |t|
      t.text :title
      t.text :description
      t.text :url
      t.integer :like
      t.references :osusume, foreign_key: true

      t.timestamps
    end
  end
end
