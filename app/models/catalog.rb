class Catalog < ActiveRecord::Base
  has_many :catalog_pages, :dependent => :destroy
  attr_accessible :name, :url
end
