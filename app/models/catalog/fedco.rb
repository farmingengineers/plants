class Catalog
  class Fedco
    include ::Catalog::Base

    def crawl
      require 'curb'
      cookiejar = Rails.root.join('tmp/fedco_cookies').to_s
      FileUtils.safe_unlink(cookiejar)
      with_catalog("Fedco Seeds", "http://www.fedcoseeds.com/") do |catalog|
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
    end
  end
end
