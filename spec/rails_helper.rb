require 'spec_helper'

RSpec.configure do |config|
  
  # Remove need for factory girl prefix
  config.include FactoryGirl::Syntax::Methods
  
  # Controller specs work with devise
  config.include Devise::TestHelpers, :type => :controller
  
  # Helpers for login
  config.include ControllerHelpers, :type => :controller
  
  # Controller to test the engine
  config.include EngineControllerTestMonkeyPatch, :type => :controller
  
  # Features use requests (for API testing)
  config.include RSpec::Rails::RequestExampleGroup, type: :feature
  
  # path helpers for the engine
  config.include PathHelpers
  
  # request helpers
  config.include Requests::JsonHelpers 

  # ApiAuth helpers
  config.include ApiAuthHelpers 
  
  # Includes the login_as method
  config.include Warden::Test::Helpers
  
  # Notifiable Rails is set to test mode
  Notifiable.delivery_method = :test

  config.before(:suite) {
    FactoryGirl.lint
    DatabaseCleaner.clean_with(:truncation)
  }
  
  config.before(:all) {
    Warden.test_mode!
    Delayed::Worker.delay_jobs = false
    
    @grocer = Grocer.server(port: 2195)
    @grocer.accept
  }
  
  config.before(:each) {
    DatabaseCleaner.start
  }
    
  config.after(:each) {
    Warden.test_reset!
    DatabaseCleaner.clean
    ApiAuthHelpers.reset_credentials
    @grocer.notifications.clear
  }
  
  config.after(:all) {
    @grocer.close
  }
  
end