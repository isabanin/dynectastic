require 'helper'

class TestSession < Test::Unit::TestCase
  
  context "Session" do
    
    should "create" do
      session = Dynectastic::Session.new(DYNECT_CUST_NAME, DYNECT_USER_NAME, DYNECT_USER_PASS)
      assert session
      assert session.token.kind_of? String
    end
    
  end
  
end