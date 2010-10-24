require 'helper'

class TestRecord < Test::Unit::TestCase
  
  context "Record" do
    
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
        :node => "new_node.dynectastictests.com",
        :ttl => 0,
        :rdata => { :cname => "something.dynectastictests.com" }
      )
    end

    context "creating" do
      
      should "save" do        
        assert @record.save
      end
      
      teardown do
        @zone.destroy
      end
      
    end

    context "updating" do
      
      setup do
        @record.save
        @zone.publish
      end
      
      teardown do 
        @zone.destroy
      end
      
      should "change rdata" do
        @record.rdata['cname'] = "something_else.dynectastictests.com"
        assert @record.save
        assert_equal "something_else.dynectastictests.com.", @record.rdata['cname']
      end
      
    end
    
  end
  
end