class NotifiableAdmin::Admin::NotificationStatusesController <NotifiableAdmin::Admin::BaseController
  
  load_and_authorize_resource :app, :class => "Notifiable::App"
  load_and_authorize_resource :notification, :class => "Notifiable::Notification", :through => :app
  
  def index
    @notification_statuses = @notification.notification_statuses
    @notification_statuses = @notification_statuses.page(params[:page])
  end
end