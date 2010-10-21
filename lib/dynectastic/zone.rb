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
      post(entity_path, :body => payload)
    end
    
    def publish
      if put(entity_path, :body => { :publish => true } )
        @published = true
      end
    end
    
    def freeze
      if put(entity_path, :body => { :freeze => true } )
        @frozen = true
      end
    end
    
    def unfreeze
      if put(entity_path, :body => { :thaw => true } )
        @frozen = false
        true
      end
    end
    
    def destroy
      delete(entity_path)
    end
    
    def published?
      @published
    end
    
    def frozen?
      @frozen
    end
  
  private
  
    def entity_path
      "/Zone/#{ name }"
    end
    
  end
  
end