module Kalipso
  class CLI < Thor

    desc "path", "print linked path for a site"
    def path(name)
      site = Site::Local.find_by_name(name)
      if site.present?
        if site.path.present?
          puts site.path
        else
          puts "Path not present. You need to link this site to a path."
        end
      else
        puts "Could not find site #{name}"
      end
    end

    desc "create", "add a site"
    def create(name = nil, path = nil)
      if name.present?
        puts "Creating #{name}"
      else
        puts "Creating a new site"
      end
      begin
        remote_site = Site::Remote.create(:name => name)
        path = path || File.expand_path("~/Sites/oncalypso/#{remote_site.name}")
        Site::Local.create({
          :name => remote_site.name,
          :id => remote_site.id,
          :path => path
        })
        Pathname.new(path).mkpath unless Pathname.new(path).exist?
        puts "Site #{remote_site.name} site created and linked to #{path}"
        
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
    
    desc "open", "open a site in browser"
    def open(site = nil)
      if site.present?
        site = Site::Local.find_by_name(site)
      else
        site = Site::Local.find_by_path(Dir.pwd)
      end
      if site.present?
        `open http://#{site.name}.oncalypso.com`
      else
        puts "Could not find site"
      end
    end
    
    desc "link", "link a local path to a site"
    def link(site, path = nil)
      site = Site::Local.find_by_name(site)
      path = path.present? ? File.expand_path(path) : Dir.pwd
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
    
    desc "fetch", "download a site and link to to a directory"
    def fetch(name)
      site = Site::Remote.find_by_name(name)
      if site.present?
        puts "fetching #{site.name}"
        local_site = Site::Local.find_or_create_by_id(site.id)
        path = File.expand_path("~/Sites/oncalypso/#{name}")
        pathname = Pathname.new(path)
        pathname.mkpath unless pathname.exist?
        local_site.name = site.name
        local_site.path = path
        local_site.save
        `rsync -arvH -e "ssh -i #{Jaysus::Local.store_dir.join('keys', 'id_rsa')}" sites@calypsoapp.com:/home/sites/#{site.name}/ #{path.gsub(/\/+$/, '')}/`
        puts "Site #{name} downloaded to #{path.gsub(/\/+$/, '')}"
      else
        "Site #{name} not found. Maybe try 'kalipso sync'"
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
          puts "uploading #{site.path} to #{site.name}.oncalypso.com"
          command = %Q[rsync -arvH -e "ssh -i #{Jaysus::Local.store_dir.join('keys', 'id_rsa')}" #{site.path.gsub(/\/+$/, '')}/ sites@calypsoapp.com:/home/sites/#{site.name}]
          `#{command}`
          puts "#{site.path} uploaded to http://#{site.name}.oncalypso.com"
        else
          puts "You need to link this site first"
        end
      else
        puts "site not found with path #{path}"
      end
    end
    
    desc "version", "print the version of the kalipso gem"
    def version
      puts File.read(File.expand_path('../../../VERSION', __FILE__))
    end
  end
end