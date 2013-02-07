class Catalog
  class HighMowing
    include ::Catalog::Base

    def crawl
      require 'anemone'
      with_catalog("High Mowing Seed", "http://www.highmowingseeds.com/") do |catalog|
        Anemone.crawl(catalog.url) do |anemone|
          anemone.focus_crawl do |page|
            page.links.select { |u| u.path =~ /^\/organic-/ }
          end
          anemone.on_every_page do |page|
            puts page.url
            catalog.catalog_pages.create(:url => page.url.to_s, :body => page.body)
          end
        end
      end
    end
  end
end
