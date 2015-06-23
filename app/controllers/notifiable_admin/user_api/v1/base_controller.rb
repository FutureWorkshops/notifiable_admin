class NotifiableAdmin::UserApi::V1::BaseController < NotifiableAdmin::ApiController

  skip_authorization_check :if => :notifiable_rails_controller?
  
  before_filter :authorize_current_api_v1_user!, :current_api_v1_user, :authenticate_from_headers!
  
  def authorize_current_api_v1_user!      

  end
  
  def current_api_v1_user
    @current_api_v1_user ||= NotifiableAdmin::User.find_or_create_by(:alias => params[:user][:alias]) if params[:user] && params[:user][:alias]
  end
  
  def current_notifiable_user
    current_api_v1_user
  end
  
  def current_ability
    @current_ability ||= UserAbility.new(current_api_v1_user)
  end
  
  def notifiable_rails_controller?
    ["notifiable_admin/user_api/v1/device_tokens", "notifiable_admin/user_api/v1/notification_statuses"].include? params[:controller]
  end
  
  private
    def authenticate_from_headers!
      access_id = ApiAuth.access_id(request)
      @app = Notifiable::App.find_by_access_id(access_id)
      head :forbidden unless @app && ApiAuth.authentic?(request, @app.secret_key)    
    end
  
end