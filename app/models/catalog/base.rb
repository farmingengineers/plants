Bundler.require(:scrape)

class Catalog
  module Base
    extend ActiveSupport::Concern

    # We could do this:
    #def scrape
    #  crawl
    #  parse
    #end

    def crawl
      catalog.catalog_pages.destroy_all
      collect_pages
    end

    def parse
      catalog.catalog_pages.each do |page|
        parse_page(page)
      end
    end

    def catalog
      @catalog ||= Catalog.where(:url => catalog_url).first_or_create!(:name => catalog_name)
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
