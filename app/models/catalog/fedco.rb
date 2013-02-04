class Catalog
  class Fedco
    include ::Catalog::Base

    def crawl
      require 'curb'
      cookiejar = Rails.root.join('tmp/fedco_cookies').to_s
      FileUtils.safe_unlink(cookiejar)
      with_catalog("Fedco Seeds", "http://www.fedcoseeds.com/") do |catalog|
        1.upto(6499) do |item_id|
          url = "#{catalog.url}seeds/search.php?item=#{item_id}"
          c = Curl::Easy.new(url) do |curl|
            curl.follow_location = true
            curl.enable_cookies = true
            curl.cookiejar = cookiejar
            curl.on_success { |easy| puts "Saving #{url}" ; catalog.catalog_pages.create!(:url => url, :body => easy.body_str) }
            curl.on_failure { |easy| "ERROR: #{easy.status} #{url}" }
          end
          c.perform
        end
      end
    end
  end
end
