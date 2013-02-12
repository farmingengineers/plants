class Catalog
  class HighMowing
    include ::Catalog::Base

    catalog_name 'High Mowing Seed'
    catalog_url  'http://www.highmowingseeds.com/'

    protected

    def collect_pages
      Anemone.crawl(catalog.url) do |anemone|
        anemone.focus_crawl do |page|
          page.links.select { |u| u.path =~ /^\/organic-/ }
        end
        anemone.on_every_page do |page|
          puts page.url
          create_page page.url.to_s, page.body
        end
      end
    end

    def parse_page(catalog_page, doc)
    end
  end
end
