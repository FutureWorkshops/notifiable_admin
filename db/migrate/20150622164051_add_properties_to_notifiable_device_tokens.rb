class AddPropertiesToNotifiableDeviceTokens < ActiveRecord::Migration
  
  def is_connection_postgres?
    connection.adapter_name.downcase.to_sym == :postgresql
  end
  
  def change
    add_column :notifiable_device_tokens, :custom_properties, :hstore if is_connection_postgres?
  end
end
