require 'helper'

class TestRecord < Test::Unit::TestCase
  
  context "Record" do
    
    setup do
      @dynect = Dynectastic.session(DYNECT_CUST_NAME, DYNECT_USER_NAME, DYNECT_USER_PASS)
      @factory = @dynect.records
    end
    
=begin
    should "save" do
      record = @factory.build("CNAME") \
                .zone("beanstalklocal.com") \
                .node("new_node.beanstalklocal.com") \
                .rdata(:cname => "something.beanstalklocal.com") \
                .ttl(1800)
      assert record.save
    end
=end
    
  end
  
end