module Dynectastic
  
  class Record < Resource
    
    attr_accessor :zone, :node, :rdata, :ttl, :type
    
    def save
      payload = {
        'rdata' => rdata,
        'ttl'   => ttl
      }
      post("/#{ factory.entity_name }/#{ zone }/#{ node }/", :body => payload)
    end
    
  end
  
end