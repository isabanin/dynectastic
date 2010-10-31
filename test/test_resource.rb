require 'helper'

class TestResource < Test::Unit::TestCase
  
  context "Resource" do
    
    setup do
      @dynect = Dynectastic.session(DYNECT_CUST_NAME, DYNECT_USER_NAME, DYNECT_USER_PASS)
      @zone = @dynect.zones.build(
        :name    => "dynectastictests.com",
        :contact => "ilya@wildbit.com",
        :ttl     => 0
      )
    end
    
    should "not have any info about last request by default" do
      assert_nil @zone.last_request
    end
    
    should "should memorize last request" do
      assert @dynect.last_request.kind_of?(Dynectastic::Request)
    end
    
  end
  
end