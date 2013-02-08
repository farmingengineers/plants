class CatalogPage < ActiveRecord::Base
  belongs_to :catalog
  has_many :catalog_items, :dependent => :destroy
  attr_accessible :body, :url
end
