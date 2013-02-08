class Catalog
  class Johnnys
    include ::Catalog::Base

    catalog_name 'Johnny\'s Selected Seeds'
    catalog_url  'http://www.johnnyseeds.com/'

    protected

    def collect_pages
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

    def parse_page(catalog_page, doc)
      if product = doc.css('#producttabs').first
        item = catalog_page.catalog_items.new

        item.name = doc.css('meta[name=description]').first['content']
        item.description = doc.css('meta[name=keywords]').first['content']
        item.organic = organic?(doc)

        product.css('.product_tab_box p').each do |tab|
          item.description << "\n\n"
          item.description << tab.text.strip
        end
      end
    end

    def organic?(doc)
      symbols = doc.css('.productResultInfo img')
      symbols.any? { |img| img['alt'] == 'Organic Seeds and Supplies' }
    end
  end
end
