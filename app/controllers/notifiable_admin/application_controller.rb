class NotifiableAdmin::ApplicationController < ActionController::Base
  helper NotifiableAdmin::ApplicationHelper
  helper ::ApplicationHelper
  
  protect_from_forgery with: :exception

  respond_to :html
  
  check_authorization :unless => :devise_controller?
  
end
