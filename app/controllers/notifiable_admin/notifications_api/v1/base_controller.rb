class NotifiableAdmin::NotificationsApi::V1::BaseController < NotifiableAdmin::ApiController
  
  prepend_before_filter :authenticate_from_headers!
  skip_before_filter :verify_authenticity_token
     
  rescue_from CanCan::AccessDenied do |exception|
    logger.debug "Access denied on #{exception.action} #{exception.subject.inspect} for #{current_notifications_api_v1_notifications_api_user}"
    head :unauthorized
  end

  def current_ability
    @current_ability ||= NotifiableAdmin::NotificationsApiUserAbility.new(current_notifications_api_v1_notifications_api_user)
  end
 
  private
    def authenticate_from_headers!
      access_id = ApiAuth.access_id(request)
      user = NotifiableAdmin::NotificationsApiUser.find_by_access_id(access_id)
      if user && ApiAuth.authentic?(request, user.secret_key)
        sign_in(:notifications_api_v1_notifications_api_user, user)
      else
        head :forbidden
      end      
    end
  
end