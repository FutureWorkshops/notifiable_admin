require 'rubygems'
require 'bundler/setup'

require 'combustion'
require 'notifiable_admin'

# needed for testing
require 'notifiable/apns/grocer'

# require delayed job before initializing combustion because otherwise DelayedJob's railties get confused
require 'delayed_job'
require 'delayed/performable_mailer'

require 'cancan/model_adapters/active_record_adapter'
require 'cancan/model_adapters/active_record_4_adapter'

Combustion.initialize! :all

require 'simplecov'
require 'simplecov-rcov'
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start 'rails'

ENV["RAILS_ENV"] ||= 'test'

require 'rspec/rails'
require 'rspec_api_documentation/dsl'
require 'factory_girl_rails'
require 'capybara/rspec'
require 'database_cleaner'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("../support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  
  #config.raise_errors_for_deprecations!

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
  
  # Infer the spec type from the containing folder
  config.infer_spec_type_from_file_location!

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
  
  # errors for deprecations
  #config.raise_errors_for_deprecations!
  
end

RspecApiDocumentation.configure do |config|

  config.format = :combined_json
  config.curl_host = "localhost:3000"
  config.curl_headers_to_filter = ["Cookie", "Host"]
  config.request_headers_to_include = ["Content-Accept", "Content-Type"]
  config.response_headers_to_include = []

  # Change the name of the API on index pages
  config.api_name = "Notifiable API"
  
  config.define_group :notifications_api do |config|
    config.filter = :notifications_api
    config.docs_dir = Rails.root.join("doc", "api", "notifications_api")
  end
  config.define_group :user_api do |config|
    config.filter = :user_api
    config.docs_dir = Rails.root.join("doc", "api", "user_api")
  end
end
