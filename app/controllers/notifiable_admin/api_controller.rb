class NotifiableAdmin::ApiController < ActionController::Base
  
  protect_from_forgery with: :null_session
  
  respond_to :json
  
  check_authorization
  
  rescue_from ActiveRecord::RecordNotFound do |error|
    render :json => {:error => error.message}, :status => :not_found
  end
  
  rescue_from CanCan::AccessDenied do |error|
    render :json => {:error => error.message}, :status => :unauthorized
  end
end