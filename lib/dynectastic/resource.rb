module Dynectastic
  
  class Resource
    
    include HTTParty
    
    attr_reader :session, :factory
    
    base_uri "https://api2.dynect.net/REST"
    headers  "Content-Type" => "application/json"
    
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
    
    def attributes=(hash)
      hash.each_pair do |name, value|
        instance_variable_set("@#{ name }", value)
      end
    end
    
  private
  
    def request(*args)
      method, path, options = args.shift, args.shift, args.last
      
      if session
        options ||= {}
        options.merge!(:headers => self.class.default_options[:headers].merge({ "Auth-Token" => session.token}))
      end
      
      if options[:body].kind_of?(Hash)
        options[:body] = options[:body].to_json
      end
      
      response = self.class.send(method, path, options)
      
      if response['status'] == 'success'
        response['data']
      else
        dynect_messages_to_exceptions(response['msgs'])
        response
      end
    end
    
    def dynect_messages_to_exceptions(messages)
      messages.each do |msg|
        if msg['LVL'] == 'ERROR'
          raise DynectError.new(msg['INFO'], msg['SOURCE'], msg['ERR_CD'])
        end
      end
    end
    
  end
  
end