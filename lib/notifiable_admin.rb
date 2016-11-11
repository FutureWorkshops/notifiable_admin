require 'rails'
require 'sass-rails'
require 'uglifier'
require 'coffee-rails'
require 'jquery-rails'
require 'jbuilder'
require 'quiet_assets'
require 'iso'
require 'rails-assets-bootstrap'
require 'rails-assets-eonasdan-bootstrap-datetimepicker'
require 'simple_form'
require 'zeroclipboard-rails'
require 'devise'
require 'devise_invitable'
require 'cancancan'
require 'api-auth'
require 'delayed_job_active_record'
require 'kaminari'
require 'bootstrap-kaminari-views'

require 'notifiable_admin/engine'
require 'notifiable'

module NotifiableAdmin
  
  def self.configure
    yield self
  end
end