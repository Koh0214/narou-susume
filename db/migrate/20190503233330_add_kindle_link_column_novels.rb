class AddKindleLinkColumnNovels < ActiveRecord::Migration[5.2]
  def change
    add_column :novels, :amazon_kindle_link, :string
  end
end
