require 'helper'

class TestRequest < Test::Unit::TestCase
  
  context "Request" do
    
    setup do
      @session = Dynectastic.session(DYNECT_CUST_NAME, DYNECT_USER_NAME, DYNECT_USER_PASS)
      @zone = @session.zones.build(
        :name    => "dynectastictests.com",
        :contact => "ilya@wildbit.com",
        :ttl     => 0
      )
    end
    
    context "complete request" do
      
      should "memorize job_id" do
        assert @session.last_request.job_id.kind_of?(Numeric)
      end
    
      should "memorize response" do
        assert @session.last_request.response
      end
      
    end
    
    context "incomplete long-running request" do
      
      setup do
        @long_running = resource = Dynectastic::Resource.new(@session)
        @request_result = @long_running.post('/REST/QPSReport/', :body => {
          :start_ts => (Time.now - 1296000).to_i,
          :end_ts => (Time.now + 1296000).to_i 
        })
      end
      
      should "return job" do
        assert @request_result.kind_of?(Dynectastic::Job)
      end
      
      should "flag resource with job_incomplete" do
        assert @request_result.incomplete?
      end
      
      should "memorize job_id" do
        assert @request_result.id.kind_of?(Numeric)
      end
      
      should "memorize response" do
        assert @long_running.last_request.response
      end
          
    end
    
    should "raise DynectError when request failed" do
    end
    
    should "retry request X times when session is busy" do
    end
    
  end
  
end