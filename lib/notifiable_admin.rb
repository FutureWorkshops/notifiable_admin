gems_to_ignore = ['notifiable-rails', 'notifiable-apns-grocer', 'rspec-mocks', 'figaro']
Gem.loaded_specs['notifiable_admin'].dependencies.each do |d|
 require d.name unless gems_to_ignore.include?(d.name)
end

require 'notifiable_admin/engine'
require 'notifiable'

module NotifiableAdmin

  mattr_accessor :custom_device_token_properties
  @@custom_device_token_properties = {}
  
  def self.configure
    yield self
  end
end