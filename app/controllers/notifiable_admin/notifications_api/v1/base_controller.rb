class NotifiableAdmin::NotificationsApi::V1::BaseController < NotifiableAdmin::ApiController
  
  prepend_before_filter :authenticate_from_headers!
  skip_before_filter :verify_authenticity_token
     
  rescue_from CanCan::AccessDenied do |exception|
    logger.debug "Access denied on #{exception.action} #{exception.subject.inspect} for #{current_user}"
    head :unauthorized
  end

  def current_ability
    @current_ability ||= NotifiableAdmin::NotificationsApiUserAbility.new(current_user)
  end
  
  def current_user
    @current_user
  end
 
  private
    def authenticate_from_headers!
      access_id = ApiAuth.access_id(request)
      user = NotifiableAdmin::NotificationsApiUser.find_by_access_id(access_id)      
      user ||= unauthorized_user
      
      if user && user.enabled? && (!user.authorization_required || ApiAuth.authentic?(request, user.secret_key))
        @current_user = user
      else
        head :forbidden
      end      
    end
    
    def unauthorized_user
      NotifiableAdmin::NotificationsApiUser.find_by_access_id_and_authorization_required(request.headers['Authorization'], false)
    end
  
end