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

Notifiable::DeviceToken.class_eval do

  belongs_to :user, class_name: "NotifiableAdmin::User"

  def self.is_adapter_postgres?
    ActiveRecord::Base.connection_config[:adapter].eql? "postgresql"
  end
  
  if Notifiable::DeviceToken.is_adapter_postgres?
    store :custom_properties, coder: HstoreCoder
    scope :where_custom_property, ->(filter) { where("custom_properties -> #{filter.postgres_where_clause}") }
  else    
    store :custom_properties, coder: JSON

    # todo this is bad for performance because it gets "all" every time
    scope :where_custom_property, ->(filter) { where(id: ids_for_custom_property(filter)) }    
  end
  
  def self.where_custom_properties(app, device_token_filters)
    device_tokens = app.device_tokens
    device_token_filters.each do |filter|
      device_tokens = device_tokens.where_custom_property(filter)          
    end
    device_tokens
  end
  
  # helpers for scopes
  def self.ids_for_custom_property(filter)
    all.select do |d|
      case filter.operator
      when "="
        d.custom_properties[filter.property.to_sym].eql?(filter.value)
      when "LIKE"
        d.custom_properties[filter.property.to_sym].include?(filter.value)
      end
    end.map(&:id)
  end
end