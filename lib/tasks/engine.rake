if ENV['RAILS_ENV'].eql? 'development'
  require 'rspec/core'
  require 'rspec/core/rake_task'

  desc 'Generate API request documentation from API specs'
  RSpec::Core::RakeTask.new('docs:api') do |t|
    t.pattern = 'spec/acceptance/**/*_spec.rb'
    t.rspec_opts = ["--format RspecApiDocumentation::ApiFormatter"]
  end
end