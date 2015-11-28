class AddPropertiesToNotifiableDeviceTokens < ActiveRecord::Migration
  def change
    add_column :notifiable_device_tokens, :custom_properties, :hstore
  end
end
