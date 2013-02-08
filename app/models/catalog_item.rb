class CatalogItem < ActiveRecord::Base
  belongs_to :catalog_page
  attr_accessible :description, :name, :organic
end
