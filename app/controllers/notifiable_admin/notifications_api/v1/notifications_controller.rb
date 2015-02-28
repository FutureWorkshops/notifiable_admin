class NotifiableAdmin::NotificationsApi::V1::NotificationsController < NotifiableAdmin::NotificationsApi::V1::BaseController

  load_and_authorize_resource :app, :class => "Notifiable::App"
  load_and_authorize_resource :notification, :class => "Notifiable::Notification", :through => :app
  
  before_filter :find_user!, :only => :create

  def create
    @notification.app = @app
    if @notification.save
      @notification.delay(:app_id => @app.id, :notification_id => @notification.id).enqueue_send(@user)
      head :status => :ok                  
    else
      render :json => n.errors, :status => :unprocessable_entity
    end           
  end
  
  private
  def find_user!
    if params[:user] && params[:user][:alias]
      @user = NotifiableAdmin::User.find_by(:alias => params[:user][:alias])
      head :status => :not_found unless @user 
    end
  end
  
  private
    def create_params
      params.require(:notification).permit(localized_notifications_attributes: [:message, :locale])
    end
  
end