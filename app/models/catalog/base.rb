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
      transaction do
        catalog.catalog_pages.destroy_all
        collect_pages
      end
    end

    def parse
      transaction do
        CatalogItem.where(:catalog_page_id => catalog.catalog_page_ids).destroy_all
        catalog.catalog_pages.each do |page|
          doc = Nokogiri::HTML(page.body)
          parse_page(page, doc)
        end
      end
    end

    def catalog
      @catalog ||= Catalog.where(:url => catalog_url).first_or_create!(:name => catalog_name)
    end

    def transaction
      ActiveRecord::Base.transaction do
        yield
      end
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
