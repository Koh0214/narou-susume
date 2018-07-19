class CreateOsusumes < ActiveRecord::Migration[5.2]
  def change
    create_table :osusumes do |t|
      t.string :title
      t.string :short_title

      t.timestamps
    end
  end
end
