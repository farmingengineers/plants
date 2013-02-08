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
      curl.on_success { |easy| puts "Saving #{easy.url}" ; catalog.catalog_pages.create!(:url => easy.url, :body => easy.body_str) }
      curl.on_failure { |easy| "ERROR: #{easy.status} #{easy.url}" }
      1.upto(6499) do |item_id|
        curl.url = "#{catalog.url}seeds/search.php?item=#{item_id}"
        curl.perform
      end
    end

    def parse_page(catalog_page)
    end
  end
end
