require 'notifiable_admin/engine'

module NotifiableAdmin

  mattr_accessor :custom_device_token_properties
  @@custom_device_token_properties = {}
  
  def self.configure
    yield self
  end
end