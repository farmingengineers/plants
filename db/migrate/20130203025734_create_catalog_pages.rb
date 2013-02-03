class CreateCatalogPages < ActiveRecord::Migration
  def change
    create_table :catalog_pages do |t|
      t.belongs_to :catalog
      t.string :url
      t.text :body

      t.timestamps
    end
    add_index :catalog_pages, :catalog_id
  end
end
