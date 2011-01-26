module Kalipso
  class CLI < Thor

    desc "create", "add a site"
    def create(name = nil)
      path = Dir.pwd
      if name.present?
        puts "Creating #{name} linked to #{path}"
      else
        puts "Creating a new site linked to #{path}"
      end
      begin
        Site::Remote.create(:name => name)
      rescue RestClient::UnprocessableEntity
        puts "There was an error uploading your site"
      end
    end
    
    desc "sites", "list all sites"
    def sites
      if Site::Local.all.empty?
        sync
      else
        Site::Local.all.each do |site|
          out = "".tap do |out|
            out << site.name
            out << " -> #{site.path}" if site.path.present?
          end
          puts out
        end
      end
    end
    
    desc "link", "link a local path to a site"
    def link(site, path)
      site = Site::Local.find_by_name(site)
      path = File.expand_path(path)
      site.update_attributes(:path => path)
      puts "#{site.name} linked to #{path}"
    end
    
    desc "unlink", "stop linking a local path to a site"
    def unlink(site)
      site = Site::Local.find_by_name(site)
      site.update_attributes(:path => "")
      puts "Site #{site.name} unlinked"
    end
    
    desc "store_dir", "show kalipso store dir"
    def store_dir
      puts Jaysus::Local.store_dir
    end
    
    desc "base_url", "show kalipso API base url"
    def base_url
      puts Jaysus::Remote.base_url
    end
    
    desc "sync", "synchronize remote changes locally"
    def sync
      puts "fetching remote sites"
      Site::Remote.all.each do |site|
        puts "syncing #{site.name}"
        local_site = Site::Local.find_or_create_by_id(site.id)
        local_site.update_attributes(site.attributes)
      end
    end
    
    desc "upload", "upload a path, eg. kalipso upload SITENAME PATH"
    def upload(name = nil)
      if name.present?
        puts "uploading #{name}"
        site = Site::Local.find_by_name(name)
        path = site.path
      else
        path = File.expand_path(Dir.pwd)
        site = Site::Local.find_by_path(path)
      end
      if site.present?
        puts "uploading #{name} from #{path}"
        if site.path.present?
          puts "uploading #{site.path} to #{site.name}.diddlydum.com"
          `rsync -arvH #{site.path.gsub(/\/+$/, '')}/ sites@diddlydum.com:/home/sites/#{site.name}`
          puts "#{site.path} uploaded to http://#{site.name}.diddlydum.com"
        else
          puts "You need to link this site first"
        end
      else
        puts "site not found with path #{path}"
      end
    end
  end
end