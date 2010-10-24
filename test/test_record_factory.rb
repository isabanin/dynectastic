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

    should "build new record" do
      record = @dynect.records.cname.build(
        :zone => "dynectastictests.com",
        :node => "ilya.dynectastictests.com",
        :ttl => 0,
        :rdata => { :cname => "something.dynectastictests.com" }
      )
      assert record
    end

    should "find record by ID" do
      record = @dynect.records.cname.find_by_id(0, :zone => "dynectastictests.com", :node => "ilya.dynectastictests.com")
      assert record
    end

    should "find all existing records" do
      records = @dynect.records.cname.find_all(:zone => "dynectastictests.com", :node => "ilya.dynectastictests.com")
      assert records.size == 1
    end

    should "set record types properly" do
      assert "AAAA",   @dynect.records.aaaa.record_type
      assert "A",      @dynect.records.a.record_type
      assert "CNAME",  @dynect.records.cname.record_type
      assert "DNSKEY", @dynect.records.dnskey.record_type
      assert "DS",     @dynect.records.ds.record_type
      assert "KEY",    @dynect.records.key.record_type
      assert "LOC",    @dynect.records.loc.record_type
      assert "MX",     @dynect.records.mx.record_type
      assert "NS",     @dynect.records.ns.record_type
      assert "PTR",    @dynect.records.ptr.record_type
      assert "RP",     @dynect.records.rp.record_type
      assert "SOA",    @dynect.records.soa.record_type
      assert "SRV",    @dynect.records.srv.record_type
      assert "TXT",    @dynect.records.txt.record_type
    end

  end
  
end