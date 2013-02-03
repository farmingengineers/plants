class CatalogPage < ActiveRecord::Base
  belongs_to :catalog
  attr_accessible :body, :url
end
