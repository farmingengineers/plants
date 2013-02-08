class CreateCatalogPrices < ActiveRecord::Migration
  def change
    create_table :catalog_prices do |t|
      t.belongs_to :catalog_item
      t.string :quantity
      t.integer :cents

      t.timestamps
    end
    add_index :catalog_prices, :catalog_item_id
  end
end
