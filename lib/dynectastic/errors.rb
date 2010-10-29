module Dynectastic
  
  class DynectError < Exception
    
    attr_reader :text, :source, :code
    
    def initialize(text, source, code)
      @text, @source, @code = text, source, code      
    end
    
    def message
      %Q[#{ text }. (SOURCE: #{ source}; CODE: #{ code })]
    end
    
  end
  
  class AuthenticationError < DynectError
    
    def message
      "Credentials you entered did not match those in Dynect's database."
    end
    
  end
  
  class SessionBusy < DynectError
    
    def message
      "This session already has a job running. Try again later."
    end
    
  end
  
end