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

        item.save
        collect_prices(item, doc)
      end
    end

    def collect_prices(item, doc)
      doc.css('.productResultInfo form tr').each do |price_row|
        product, price, quantity = price_row.css('td')
        if price.present? && (price.text =~ /\$(\d*\.\d*)/) && (product = product.css('span').last)
          price = $1
          product = product.text
          quantity = quantity.try(:text)
          catalog_price = CatalogPrice.new
          catalog_price.quantity = "#{product} #{quantity}"
          catalog_price.cents = price.to_f * 100
          item.catalog_prices << catalog_price
        end
      end
    end

    def organic?(doc)
      symbols = doc.css('.productResultInfo img')
      symbols.any? { |img| img['alt'] == 'Organic Seeds and Supplies' }
    end
  end
end
