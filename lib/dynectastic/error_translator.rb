module Dynectastic
  
  module ErrorTranslator
  
    extend self
  
    def translate_to_exception(dynect_msg)
      info, source, code = dynect_msg['INFO'], dynect_msg['SOURCE'], dynect_msg['ERR_CD']
      
      if info =~ /login: Credentials you entered did not match those in our database./i
        return AuthenticationError.new(info, source, code)
      end
      
      DynectError.new(info, source, code)
    end
  
  end
  
end