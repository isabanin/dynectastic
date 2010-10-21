require 'helper'

class TestZoneFactory < Test::Unit::TestCase
  
  context "ZoneFactory" do
    
    setup do
      @dynect = Dynectastic.session(DYNECT_CUST_NAME, DYNECT_USER_NAME, DYNECT_USER_PASS)
      @factory = @dynect.zones
      @zone = @factory.build(
        :name    => "dynectastictests.com",
        :contact => "ilya@wildbit.com",
        :ttl     => 1800
      )
      @zone.save
    end
    
    teardown do
      @zone.destroy
    end
  
    should "build new zone" do
      zone = @factory.build(:name => "new_zone.name", :contact => "ilya@wildbit.com", :ttl => 1800)
      assert_equal "ilya@wildbit.com", zone.contact
      assert_equal 1800, zone.ttl
      assert_equal "new_zone.name", zone.name
    end
    
    should "find zone by name" do
      zone = @factory.find_by_name("dynectastictests.com")
      assert_equal "dynectastictests.com", zone.name
    end
    
    should "find all existing zones" do
      zones = @factory.find_all
      assert zones.find{|z| z.name == 'dynectastictests.com'}
    end

  end
  
end