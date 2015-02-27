class NotifiableAdmin::SuperAdmin::BaseController < NotifiableAdmin::ApplicationController
  
  layout "admin"    
  
  before_filter :authenticate_admin!
      
  rescue_from CanCan::AccessDenied do |exception|
    logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    #redirect_to admin_account_app_notifications_path(@account, current_admin.default_app), :alert => exception.message
    redirect_to "/403.html"
  end
  
  def current_ability
    @current_ability ||= NotifiableAdmin::SuperAdminAbility.new(current_admin)
  end
end