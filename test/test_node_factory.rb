require 'helper'

class TestNodeFactory < Test::Unit::TestCase
  
  context "NodeFactory" do
    
    setup do
      @dynect = Dynectastic.session(DYNECT_CUST_NAME, DYNECT_USER_NAME, DYNECT_USER_PASS)
      @zone = @dynect.zones.build(
        :name    => "dynectastictests.com",
        :contact => "ilya@wildbit.com",
        :ttl     => 1800
      )
      @zone.save

      @record = @dynect.records.cname.build(
        :zone => "dynectastictests.com",
        :node => "ilya.dynectastictests.com",
        :ttl => 0,
        :rdata => { :cname => "something.dynectastictests.com" }
      )
      @record.save
    end
    
    teardown do
      @zone.destroy
    end
    
    should "delete" do
      @dynect.nodes.destroy("dynectastictests.com", "ilya.dynectastictests.com")
    end
    
  end
  
end