class NotifiableAdmin::Admin::BaseController < NotifiableAdmin::ApplicationController
  
  layout "admin"    
  
  before_filter :authenticate_admin!, :find_apps, :find_account
      
  rescue_from CanCan::AccessDenied do |exception|
    logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    #redirect_to admin_account_app_notifications_path(@account, current_admin.default_app), :alert => exception.message
    redirect_to "/403.html"
  end
  
  def find_account
    @account = NotifiableAdmin::Account.find(params[:account_id]) if params[:account_id]
  end
  
  def find_apps
    @apps = Notifiable::App.accessible_by(current_ability, :read).order(:name)
  end
  
  def current_ability
    @current_ability ||= NotifiableAdmin::AdminAbility.new(current_admin)
  end
end