class NotifiableAdmin::NotificationsApi::V1::NotificationsController < NotifiableAdmin::NotificationsApi::V1::BaseController

  load_and_authorize_resource :app, :class => "Notifiable::App"
  load_and_authorize_resource :notification, :class => "Notifiable::Notification", :through => :app
  
  before_filter :find_user!, :only => :create

  def create
    @notification.app = @app
    if @notification.save
      if @user
        @notification.delay_private @user 
      elsif @notification.device_token_filters.count == 0
        @notification.delay_public                            
      else
        @notification.delay_filtered
      end
      
      head :status => :ok                  
    else
      render :json => n.errors, :status => :unprocessable_entity
    end           
  end
  
  private
  def find_user!
    if params[:user] && params[:user][:alias]
      @user = NotifiableAdmin::User.find_by(alias: params[:user][:alias], app_id: @app.id)
      head :status => :not_found unless @user 
    end
  end
  
  def create_params
      params.require(:notification).permit(localized_notifications_attributes: [:message, :locale, :params], device_token_filters_attributes: [:property, :operator, :value]).tap do |whitelisted|      
      # whitelist any params
      whitelisted[:localized_notifications_attributes].each_with_index do |item, index|
        item[:params] = params[:notification][:localized_notifications_attributes][index][:params]
      end
      
    end
  end
  
end