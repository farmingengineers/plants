catalogs = %w(johnnys fedco high_mowing)

desc 'Crawl all the catalogs'
task :crawl => catalogs.map { |catalog| "crawl:#{catalog}" }

desc 'Parse the local copy of the catalog'
task :parse => catalogs.map { |catalog| "parse:#{catalog}" }

namespace :crawl do
  catalogs.each do |catalog|
    desc "Crawl the #{catalog.titleize} catalog"
    task catalog => :environment do
      catalog_class = "Catalog::#{catalog.classify}".constantize
      catalog_class.new.crawl
    end
  end
end

namespace :parse do
  catalogs.each do |catalog|
    desc "Parse the local copy of the #{catalog.titleize} catalog"
    task catalog => :environment do
      catalog_class = "Catalog::#{catalog.classify}".constantize
      catalog_class.new.parse
    end
  end
end
