class AddColumnNovels < ActiveRecord::Migration[5.2]
  def change
    add_column :novels, :amazon_image_link, :string
    add_column :novels, :amazon_link, :string
  end
end
