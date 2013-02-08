class CreateCatalogItems < ActiveRecord::Migration
  def change
    create_table :catalog_items do |t|
      t.belongs_to :catalog_page
      t.string :name
      t.boolean :organic
      t.text :description

      t.timestamps
    end
    add_index :catalog_items, :catalog_page_id
  end
end
