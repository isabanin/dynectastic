require 'helper'

class TestDynectastic < Test::Unit::TestCase
  
  context "Dynectastic" do
  
    should "create session" do
      dynect = Dynectastic.session(DYNECT_CUST_NAME, DYNECT_USER_NAME, DYNECT_USER_PASS)
      assert dynect
      assert dynect.token.kind_of? String
    end
    
  end
  
end
