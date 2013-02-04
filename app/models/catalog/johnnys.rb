class Catalog
  class Johnnys
    include ::Catalog::Base

    def crawl
      require 'anemone'
      with_catalog("Johnny's Selected Seeds", "http://www.johnnyseeds.com/") do |catalog|
        Anemone.crawl(catalog.url) do |anemone|
          anemone.focus_crawl do |page|
            page.links.select { |u| u.path =~ /^\/[cp]-/ and u.query.nil? }
          end
          anemone.on_every_page do |page|
            puts page.url
            if page.url.path =~ /^\/p-/
              catalog.catalog_pages.create(:url => page.url.to_s, :body => page.body)
            end
          end
        end
      end
    end
  end
end
