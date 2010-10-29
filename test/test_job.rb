require 'helper'

class TestJob < Test::Unit::TestCase
  
  context "Job" do
    setup do
      @dynect = Dynectastic.session(DYNECT_CUST_NAME, DYNECT_USER_NAME, DYNECT_USER_PASS)
      @zone = @dynect.zones.build(
        :name    => "dynectastictests.com",
        :contact => "ilya@wildbit.com",
        :ttl     => 0
      )
      @zone.save
    end
    
    teardown do
      @zone.destroy
    end
    
    should "be initialized when request is long running" do
      start_ts = Time.now - 1296000
      end_ts = Time.now + 1296000
      resource = Dynectastic::Resource.new(@zone.session)
      resource.post('/REST/QPSReport/', :body => {
        :start_ts => start_ts.to_i,
        :end_ts => end_ts.to_i 
      })
    end

  end
  
end