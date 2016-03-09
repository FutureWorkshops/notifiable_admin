Notifiable::DeviceToken.class_eval do

  def self.is_adapter_postgres?
    ActiveRecord::Base.connection_config[:adapter].eql? "postgresql"
  end
  
  if Notifiable::DeviceToken.is_adapter_postgres?
    store :custom_properties, coder: HstoreCoder
    scope :where_custom_property, ->(name, value) { where("custom_properties -> '#{name}' = '#{value}'") }
    scope :where_custom_property_like, -> (name, value) { where("custom_properties -> '#{name}' LIKE '%#{value}%'")}
  else    
    store :custom_properties, coder: JSON

    # todo this is baaad because it gets "all" every time
    # should limit the query somehow and test better
    scope :where_custom_property, ->(key, value) { where(id: all.select{|d| d.custom_properties[key.to_sym].eql?(value) }.map(&:id)) }    
    scope :where_custom_property_like, ->(key, value) { where(id: all.select{|d| d.custom_properties[key.to_sym].include?(value) }.map(&:id)) }    

  end  
end

class HstoreCoder
  class << self
    def load(hash)
      hash
    end

    def dump(value)
      value.to_hash
    end
  end
end