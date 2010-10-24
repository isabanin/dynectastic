module Dynectastic
  
  class ZoneFactory < Resource
    
    def build(attributes)
      zone = Dynectastic::Zone.new(session, self)
      zone.attributes = attributes
      zone
    end
    
    def find_by_name(name=nil)
      build api_parameters_to_attributes(get("#{ entity_name }/#{ name }/"))
    end
    
    def find_all
      zones = []
      get("#{ entity_name }/").each do |full_zone_path|
        zone_name = full_zone_path.split('/').last
        zones << find_by_name(zone_name)
      end
      zones
    end
    
    def publish(name)
      put("#{ entity_name }/#{ name }", :body => { :publish => true } )
    end
    
    def freeze(name)
      put("#{ entity_name }/#{ name }", :body => { :freeze => true } )
    end
    
    def unfreeze(name)
      put("#{ entity_name }/#{ name }", :body => { :thaw => true } )
    end
    
    def destroy(name)
      delete("#{ entity_name }/#{ name }")
    end
    
    def entity_name
      "/Zone"
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