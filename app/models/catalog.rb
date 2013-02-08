class Catalog < ActiveRecord::Base
  has_many :catalog_pages, :dependent => :destroy
  has_many :catalog_items, :through => :catalog_pages
  attr_accessible :name, :url
end
