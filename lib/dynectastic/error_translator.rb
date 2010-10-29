module Dynectastic
  
  module ErrorTranslator
  
    extend self
  
    def translate_to_exception(dynect_msg)
      info, source, code = dynect_msg['INFO'], dynect_msg['SOURCE'], dynect_msg['ERR_CD']
      
      case info
      when /Credentials you entered did not match those in our database/i
        return AuthenticationError.new(info, source, code)
      when /This session already has a job running/i
        return SessionBusy.new(info, source, code)
      end
      
      DynectError.new(info, source, code)
    end
  
  end
  
end