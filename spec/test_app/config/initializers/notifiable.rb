Notifiable.configure do |config|
  
  # The controller class that the DeviceTokenController should extend
	config.api_controller_class = NotifiableAdmin::UserApi::V1::BaseController
  
  # The class representing the holder of the device
	config.user_class = NotifiableAdmin::User
  
  # Set the delivery method to test, preventing notifications from being sent
  config.delivery_method = Rails.env.test? ? :test : :send
  
  # Locales for notifications
  config.locales = [:en, :ar]
  
  # Set the params permitted for creation of device tokens
  config.api_device_token_params = [:token, :provider, :locale]

end
