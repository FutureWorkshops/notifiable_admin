$:.push File.expand_path("../lib", __FILE__)

require "notifiable_admin/version"

Gem::Specification.new do |s|
  s.name        = "notifiable_admin"
  s.version     = NotifiableAdmin::VERSION
  s.authors     = ["Matt Brooke-Smith"]
  s.email       = ["matt@futureworkshops.com"]
  s.homepage    = "http://www.futureworkshops.com"
  s.summary     = "Push Notifications Administration Engine"
  s.description = "Push Notifications Administration Engine"
  s.licenses    = ["Apache 2.0"]

  s.files = Dir["{app,config,db,lib,doc}/**/*", "LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]
  s.required_ruby_version = '>= 2.3.1'
  
  # Core
  s.add_dependency 'rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'uglifier'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jbuilder'
  s.add_dependency 'quiet_assets'
  s.add_dependency 'iso'

  # UI
  s.add_dependency 'rails-assets-bootstrap', '~> 3.3.2'
  s.add_dependency 'rails-assets-eonasdan-bootstrap-datetimepicker', '~> 4.0.0'
  s.add_dependency 'simple_form', '~> 3.1.0'
  s.add_dependency "zeroclipboard-rails", '~> 0.1.1'
  s.add_dependency 'cocoon', '~> 1.2.9'

  # Authentication
  s.add_dependency 'devise', '~> 3.4.1'
  s.add_dependency 'devise_invitable', '~> 1.6.1'
  s.add_dependency 'cancancan', '~> 1.13.1'
  s.add_dependency 'api-auth', '~> 1.1.0'

  # Push Notifications
  s.add_dependency 'notifiable-rails', '>= 0.24.3'

  # Background processing
  s.add_dependency 'delayed_job_active_record', '~> 4.0.3'

  # Pagination
  s.add_dependency "kaminari", "~> 0.15.1"
  s.add_dependency "bootstrap-kaminari-views", "~> 0.0.3"
  
  # Testing dependencies
  s.add_development_dependency 'combustion', '~> 0.5.4'
  s.add_development_dependency 'notifiable-apns-grocer', '~> 0.13.0'
  s.add_development_dependency 'notifiable-gcm-spacialdb', '~> 0.9.0'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails', '~> 3.0.2'
  s.add_development_dependency 'rspec-html-matchers', '~> 0.6.1'
  s.add_development_dependency 'rspec-mocks', '~> 3.0.4'
  s.add_development_dependency 'rspec_api_documentation', '~> 4.1.0'
  s.add_development_dependency 'capybara', '~> 2.4.1'
  s.add_development_dependency 'factory_girl_rails', '~> 4.4.1'
  s.add_development_dependency "database_cleaner", "~> 1.2.0"
  s.add_development_dependency 'simplecov', '~> 0.8.2'
  s.add_development_dependency "simplecov-rcov", "~> 0.2.3"
  s.add_development_dependency "json_spec", "~> 1.1.1"
  s.add_development_dependency "launchy", "~> 2.4.2"
  s.add_development_dependency "byebug"

end
