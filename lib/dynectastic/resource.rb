module Dynectastic
  
  class Resource
    
    attr_reader :session, :factory
    attr_accessor :last_request
    
    def initialize(session, factory=nil)
      @session = session
      @factory = factory
    end
    
    def get(*args)
      request(:get, *args)
    end
    
    def post(*args)
      request(:post, *args)
    end
    
    def put(*args)
      request(:put, *args)
    end
    
    def delete(*args)
      request(:delete, *args)
    end
    
    def attributes=(smth)
      return smth unless smth.kind_of?(Hash)
      smth.each_pair do |name, value|
        instance_variable_set("@#{ name }", value)
      end
    end
    
  private
  
    def request(*args)
      @last_request = Request.new(self)
      @last_request.perform(*args)
    end
    
  end
  
end