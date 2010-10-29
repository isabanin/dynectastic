module Dynectastic
  
  class Session < Resource
    
    attr_reader :token, :api_version
    
    def initialize(customer_name, user_name, password)
      payload = {
        :customer_name => customer_name,
        :user_name     => user_name,
        :password      => password
      }.to_json
      
      response     = post(entity_base, :body => payload)
      @token       = response['token']
      @api_version = response['version']
    end
    
    def zones
      Dynectastic::ZoneFactory.new(self)
    end
    
    def nodes
      Dynectastic::NodeFactory.new(self)
    end
    
    def records
      Dynectastic::RecordFactory.new(self)
    end
    
    def entity_base
      "/REST/Session"
    end
    
  end
  
end