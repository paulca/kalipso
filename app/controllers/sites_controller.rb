class SitesController
  
  def index
    Site::Remote.all.each do |site|
      puts "#{site.name}"
    end
  end
  
  def create
    site = Site::Remote.create(params[:site])
    puts "Site #{site.name} created at http://#{site.name}.oncalypso.com"
  end

end