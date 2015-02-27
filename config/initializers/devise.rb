Devise.setup do |config|
  config.router_name = :notifiable_admin
  config.parent_controller = 'ActionController::Base'
end