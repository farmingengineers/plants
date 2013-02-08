class CatalogPrice < ActiveRecord::Base
  belongs_to :catalog_item
  attr_accessible :cents, :quantity
end
