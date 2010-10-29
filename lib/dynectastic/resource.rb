module Dynectastic
  
  class Resource
    
    include HTTParty
    
    attr_reader :session, :factory
    
    base_uri     API_URL
    headers      "Content-Type" => "application/json"
    #debug_output $stdout
    
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
  
    def default_headers
      self.class.default_options[:headers]
    end
  
    def request(*args)
      method, path, options = args.shift, args.shift, args.last
      options ||= {}
      prepare_options(options)
      process_response(self.class.send(method, path, options))
    end
    
    def prepare_options(options)
      if session        
        options = options.merge!(:headers => default_headers.merge({ "Auth-Token" => session.token}))
      end
      
      if options[:body].kind_of?(Hash)
        options[:body] = options[:body].to_json
      end
    end
    
    def process_response(response)
      if response['status'] == 'success'
        response['data']
      else
        convert_dynect_messages_to_exceptions(response['msgs'])
        response
      end
    end
    
    def convert_dynect_messages_to_exceptions(messages)
      messages.each do |msg|
        if msg['LVL'] == 'ERROR'
          raise ErrorTranslator.translate_to_exception(msg)
        end
      end
    end
    
  end
  
end