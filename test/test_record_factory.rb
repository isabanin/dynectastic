require 'helper'

class TestRecordFactory < Test::Unit::TestCase
  
  context "RecordFactory" do
    
    setup do
      @dynect = Dynectastic.session(DYNECT_CUST_NAME, DYNECT_USER_NAME, DYNECT_USER_PASS)
      @zone = @dynect.zones.build(
        :name    => "dynectastictests.com",
        :contact => "ilya@wildbit.com",
        :ttl     => 1800
      )
      @zone.save
      @factory = @dynect.records
      @record = @factory.cname.build(
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
  
    should "build new record" do
      record = @factory.cname.build(
        :zone => "dynectastictests.com",
        :node => "ilya.dynectastictests.com",
        :ttl => 0,
        :rdata => { :cname => "something.dynectastictests.com" }
      )
      assert record
    end

    should "find record by ID" do
      record = @factory.find_by_id(@record.id, :in => "dynectastictests.com")
      assert record
    end

    should "find all existing records" do
      records = @factory.records.find_all(:in => "dynectastictests.com")
      assert records
    end

    should "set record types properly" do
      assert "AAAA",   @factory.aaaa
      assert "A",      @factory.a
      assert "CNAME",  @factory.cname
      assert "DNSKEY", @factory.dnskey
      assert "DS",     @factory.ds
      assert "KEY",    @factory.key
      assert "LOC",    @factory.loc
      assert "MX",     @factory.mx
      assert "NS",     @factory.ns
      assert "PTR",    @factory.ptr
      assert "RP",     @factory.rp
      assert "SOA",    @factory.soa
      assert "SRV",    @factory.srv
      assert "TXT",    @factory.txt
    end

  end
  
end