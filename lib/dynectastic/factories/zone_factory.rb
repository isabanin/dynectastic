module Dynectastic
  
  class ZoneFactory < Resource
    
    def build(attributes)
      zone = Dynectastic::Zone.new(session)
      zone.attributes = attributes
      zone
    end
    
    def find_by_name(name=nil)
      build api_parameters_to_attributes(get("/Zone/#{ name }/"))
    end
    
    def find_all
      zones = []
      get("/Zone/").each do |full_zone_path|
        zone_name = full_zone_path.split('/').last
        zones << find_by_name(zone_name)
      end
      zones
    end
    
  private
  
    def api_parameters_to_attributes(api_params)
      {
        :name         => api_params['zone'],
        :contact      => api_params['rname'],
        :ttl          => api_params['ttl'],
        :serial_style => api_params['serial_style'],
        :type         => api_params['zone_type']
      }
    end
    
  end
  
end