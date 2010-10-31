module Dynectastic
  
  class Request
    
    include HTTParty
    
    base_uri     API_URL
    headers      "Content-Type" => "application/json"
    #debug_output $stdout
    
    attr_reader :resource, :attempts, :response, :job_id, :job_incomplete
    
    def initialize(resource)
      @resource = resource
    end
    
    def job
      if job_id
        Job.new(self)
      end
    end
    
    def perform(*args)
      method, path, options = args.shift, args.shift, args.last
      options ||= {}
      prepare_options(options)
      reset_attempts
      
      begin
        process_response(self.class.send(method, path, options))
      rescue HTTParty::RedirectionTooDeep => e
        if e.response.body.include?("/REST/Job")
          memorize_response_data(e.response)
          job
        else
          raise e
        end
      
      rescue SessionBusy => e
        if attempts_left?
          sleep(10)
          increment_attempts      
          retry
        else
          raise e
        end
      end
    end
    
  private
  
    def default_headers
      self.class.default_options[:headers]
    end
    
    def prepare_options(options)
      if resource.session        
        options = options.merge!(:headers => default_headers.merge({ "Auth-Token" => resource.session.token}))
      end
      
      if options[:body].kind_of?(Hash)
        options[:body] = options[:body].to_json
      end
    end
    
    def process_response(response)
      memorize_response_data(response)
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
    
    def memorize_response_data(response)
      @response = response
      
      if response.kind_of?(Net::HTTPTemporaryRedirect)
        @job_id = extract_job_id_from_response(response)
        @job_incomplete = true
      else
        @job_id = response['job_id']
      end
    end
    
    def extract_job_id_from_response(response)
      response.body.scan(/\/REST\/Job\/(\d+)/i).flatten.first.to_i
    end
    
    def increment_attempts
      @attempts ||= 0
      @attempts += 1
    end
    
    def reset_attempts
      @attempts = 0
    end
    
    def attempts_left?
      @attempts < RETRIES
    end
    
  end
  
end