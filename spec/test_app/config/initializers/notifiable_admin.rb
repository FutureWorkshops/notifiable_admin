NotifiableAdmin.configure do |config|

  # Set the params for custom properties
  config.custom_device_token_properties = {:device_name => :text, :onsite => :select}

end
