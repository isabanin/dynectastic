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
  
end