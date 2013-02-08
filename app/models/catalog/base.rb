Bundler.require(:scrape)

class Catalog
  module Base
    extend ActiveSupport::Concern

    def with_catalog
      Catalog.where(:url => catalog_url).destroy_all
      yield Catalog.create!(:name => catalog_name, :url => catalog_url)
    end

    module ClassMethods
      def catalog_name(name)
        define_method(:catalog_name) { name }
      end
      def catalog_url(url)
        define_method(:catalog_url) { url }
      end
    end
  end
end
