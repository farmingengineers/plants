class Catalog
  class Johnnys
    include ::Catalog::Base

    catalog_name 'Johnny\'s Selected Seeds'
    catalog_url  'http://www.johnnyseeds.com/'

    def crawl
      with_catalog do |catalog|
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

    def parse
    end
  end
end
