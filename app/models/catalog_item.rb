class CatalogItem < ActiveRecord::Base
  belongs_to :catalog_page
  has_many :catalog_prices, :dependent => :destroy
  attr_accessible :description, :name, :organic
end
