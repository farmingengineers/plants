class Catalog
  class Fedco
    include ::Catalog::Base

    catalog_name 'Fedco Seeds'
    catalog_url  'http://www.fedcoseeds.com/'

    protected

    def collect_pages
      cookiejar = Rails.root.join('tmp/fedco_cookies').to_s
      FileUtils.safe_unlink(cookiejar)
      curl = Curl::Easy.new
      curl.follow_location = true
      curl.enable_cookies = true
      curl.cookiejar = cookiejar
      curl.on_success { |easy| puts "Saving #{easy.url}" ; create_page easy.url, easy.body_str }
      curl.on_failure { |easy| "ERROR: #{easy.status} #{easy.url}" }
      1.upto(6499) do |item_id|
        curl.url = "#{catalog.url}seeds/search.php?item=#{item_id}"
        curl.perform
      end
    end

    def parse_page(catalog_page, doc)
      name = doc.css('title').first.text.sub(/^Fedco Seeds - /, '')
      if name != 'Catalog Search'
        order_form = doc.css('form[name=order]').first
        description_cell = order_form.css('td')[1]
        name = description_cell.css('strong').first.text.gsub(/\s+/, ' ')
        description = description_cell.css('.times14').text

        item = catalog_page.catalog_items.new
        item.name = name
        item.description = description
        item.organic = name =~ /OG/
        item.save

        collect_prices(item, order_form)
      end
    end

    def collect_prices(item, order_form)
      desc_table = order_form.css('table')[0]
      desc_table.css('font').each do |price|
        if price.text.strip =~ /^([A-Z])=(.*) for \$([\d.]+)/
          name, quantity, price = $1, $2, $3
          catalog_price = CatalogPrice.new
          catalog_price.quantity = "#{name} #{quantity}"
          catalog_price.cents = price.to_f * 100
          item.catalog_prices << catalog_price
        end
      end
    end
  end
end
