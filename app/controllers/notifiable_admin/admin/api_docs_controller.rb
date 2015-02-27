class NotifiableAdmin::Admin::ApiDocsController <NotifiableAdmin::Admin::BaseController

  def index
    authorize! :read, NotifiableAdmin::NotificationsApiUser
    
    @json = JSON.parse(File.read(File.join(Rails.root, 'doc', 'api', 'combined.json')))
  end
  
end

