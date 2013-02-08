Bundler.require(:scrape)

class Catalog
  module Base
    def with_catalog(name, url)
      Catalog.where(:url => url).destroy_all
      yield Catalog.create!(:name => name, :url => url)
    end
  end
end
