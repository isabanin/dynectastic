require 'helper'

class TestZone < Test::Unit::TestCase
  
  context "Zone" do
    
    setup do
      @dynect = Dynectastic.session(DYNECT_CUST_NAME, DYNECT_USER_NAME, DYNECT_USER_PASS)
      @factory = @dynect.zones
      @zone = @factory.build(
        :name    => "dynectastictests.com",
        :contact => "ilya@wildbit.com",
        :ttl     => 0
      )
    end
    
    context "creating" do
      
      should "save" do        
        assert @zone.save
      end
      
      teardown do
        @zone.destroy
      end
      
    end

    context "updating" do
      
      setup do
        @zone.save
      end
      
      teardown do
        @zone.destroy
      end
    
      should "publish" do
        assert_nil @zone.published?
        assert @zone.publish
        assert @zone.published?
      end
    
      should "freeze" do
        assert_nil @zone.frozen?
        assert @zone.freeze
        assert @zone.frozen?
      end
    
      should "unfreeze" do
        @zone.freeze
        assert @zone.frozen?
        assert @zone.unfreeze
        assert_equal false, @zone.frozen?
      end
      
    end
    
    context "deleting" do
      
      setup do
        @zone.save
      end
      
      should "destroy" do
        assert @zone.destroy
      end
      
    end
 
  end
  
end