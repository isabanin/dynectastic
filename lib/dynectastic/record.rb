module Dynectastic
  
  class Record < Resource
    
    attr_accessor :zone, :node, :rdata, :ttl, :type, :record_id
    
    def save
      payload = {
        'rdata' => rdata,
        'ttl'   => ttl
      }

      self.attributes = record_id ? update(payload) : create(payload)
    end
    
  private
  
    def update(payload)
      put("#{ entity_path }/#{ record_id }/", :body => payload)
    end
    
    def create(payload)
      post("#{ entity_path }/", :body => payload)
    end
  
    def entity_path
      "/#{ factory.entity_name }/#{ zone }/#{ node }"
    end
    
  end
  
end