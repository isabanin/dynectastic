require 'helper'

class TestResource < Test::Unit::TestCase
  
  context "Resource" do
    
    should "raise an exception on bad Dynect request" do
      assert_raises Dynectastic::DynectError do
        Dynectastic.session("some", "strange", "stuff")
      end
    end
  
  end
  
end