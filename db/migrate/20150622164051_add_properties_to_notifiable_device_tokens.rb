class AddPropertiesToNotifiableDeviceTokens < ActiveRecord::Migration
  def change
    add_column :notifiable_device_tokens, :settings, :hstore
  end
end