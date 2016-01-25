class NotifiableAdmin::ApplicationController < ActionController::Base
  helper NotifiableAdmin::ApplicationHelper
  helper ::ApplicationHelper if File.exists?(File.join(Rails.root, "app", "helpers", "application_helper.rb"))
  
  protect_from_forgery with: :exception

  respond_to :html
  
  check_authorization :unless => :devise_controller?
  
end
