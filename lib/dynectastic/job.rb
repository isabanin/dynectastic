module Dynectastic
  
  class Job < Resource
    
    attr_reader :request, :id, :incomplete
    
    def initialize(request)
      @request    = request
      @id         = request.job_id
      @incomplete = request.job_incomplete
    end
    
    def complete?
      not incomplete?
    end
    
    def incomplete?
      !! @incomplete
    end
    
  end
  
end