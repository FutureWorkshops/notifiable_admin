class NotifiableAdmin::Admin::ApiDocsController <NotifiableAdmin::Admin::BaseController

  def index
    authorize! :read, NotifiableAdmin::NotificationsApiUser
    
    @notifications_api_json = JSON.parse(File.read(File.join(Rails.root, 'doc', 'api', 'notifications_api', 'combined.json')))
    @user_api_json = JSON.parse(File.read(File.join(Rails.root, 'doc', 'api', 'user_api', 'combined.json')))
  end
  
end

