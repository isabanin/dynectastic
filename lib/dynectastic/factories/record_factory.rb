module Dynectastic
  
  class RecordFactory < Resource
    
    def self.record_types(*attrs)
      attrs.each do |attr_name|
        class_eval do
          attr_reader :record_type
        end
        eval %Q[
          def #{ attr_name }
            @record_type = "#{ attr_name }".upcase
            self
          end
        ]
      end
    end
    
    record_types :aaaa, :any, :a, :cname, :dnskey, :ds, :key, :loc, :mx, :ns, :ptr, :rp, :soa, :srv, :txt 
    
    def build(attributes)
      record = Dynectastic::Record.new(session, self)
      record.type       = record_type
      record.attributes = attributes
      record
    end
    
    def find_by_id(id, options={})
      build get("#{ entity_base }/#{ options[:zone] }/#{ options[:node] }/#{ id }")
    end
    
    def find_all(options={})
      records = []
      get("#{ entity_base }/#{ options[:zone] }/#{ options[:node] }/").each do |record_url|
        record_id = record_url.split("/").last
        records << find_by_id(record_id, options)
      end
      records
    end
    
    def entity_base
      "/REST/#{ entity_name }"
    end
    
    def entity_name
      "#{ record_type }Record"
    end
    
  end
  
end