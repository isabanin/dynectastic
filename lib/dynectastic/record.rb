module Dynectastic
  
  class Record < Resource
    
    def save
      payload = {
        'rdata' => rdata,
        'ttl'   => ttl
      }
      post("/#{ self.class.api_entity }/#{ zone }/#{ node }/", :body => payload)
    end
    
  end
  
end