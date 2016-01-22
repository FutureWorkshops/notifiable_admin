Notifiable::DeviceToken.class_eval do

  def self.is_adapter_postgres?
    ActiveRecord::Base.connection_config[:adapter].eql? "postgresql"
  end
  
  if Notifiable::DeviceToken.is_adapter_postgres?
    store_accessor :custom_properties
    scope :where_custom_property, ->(name, value) { where("custom_properties -> '#{name}' = '#{value}'") }
  else    
    store :custom_properties, accessors: NotifiableAdmin.custom_device_token_properties.keys, coder: JSON

    # todo this is baaad because it gets "all" every time
    # should limit the query somehow and test better
    scope :where_custom_property, ->(key, value) { where(id: all.select{|d| d.custom_properties[key.to_sym].eql?(value) }.map(&:id)) }    

  end
  
end
