module Dynectastic
  
  class Zone < Resource
    
    attr_accessor :name, :contact, :ttl, :serial, :serial_style
    attr_reader :zone_type
    
    def save
      payload = {
        'rname'        => contact,
        'serial_style' => serial,
        'ttl'          => ttl
      }
      self.attributes = post("#{ factory.entity_name }/#{ name }", :body => payload)
    end
    
    def publish
      if factory.publish(name)
        @published = true
      end
    end
    
    def freeze
      if factory.freeze(name)
        @frozen = true
      end
    end
    
    def unfreeze
      if factory.unfreeze(name)
        @frozen = false
        true
      end
    end
    
    def destroy
      factory.destroy(name)
    end
    
    def published?
      @published
    end
    
    def frozen?
      @frozen
    end
    
  end
  
end