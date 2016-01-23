class AddPropertiesToNotifiableDeviceTokens < ActiveRecord::Migration
  
  def is_connection_postgres?
    connection.adapter_name.downcase.to_sym == :postgresql
  end
  
  def change
    if is_connection_postgres?
      add_column :notifiable_device_tokens, :custom_properties, :hstore
    else
      add_column :notifiable_device_tokens, :custom_properties, :string   
    end
  end
end
