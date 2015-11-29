class NotifiableAdmin::Admin::ApiDocsController <NotifiableAdmin::Admin::BaseController

  def index
    authorize! :read, NotifiableAdmin::NotificationsApiUser
    
    base = File.join(File.dirname(__FILE__), "..", "..", "..", "..", "doc", "api")
    @notifications_api_json = JSON.parse(File.read(File.join(base, 'notifications_api', 'combined.json')))
    @user_api_json = JSON.parse(File.read(File.join(base, 'user_api', 'combined.json')))
  end
  
end

