class NotifiableAdmin::Admin::NotificationsController <NotifiableAdmin::Admin::BaseController

  load_and_authorize_resource :app, :class => "Notifiable::App"
  load_and_authorize_resource :class => "Notifiable::Notification", :through => :app
    
  prepend_before_filter :find_user, :only => [:new, :create]
  prepend_before_filter :parse_params, :only => :create
    
  def new
    region_codes = Notifiable::DeviceToken.where(app: @app).uniq.pluck(:locale).collect{|l| l.split("_").last}.uniq.sort
    @regions = region_codes.map {|e| r = ISO::Region.find(e); [r.name, e] if r }
    @regions = [["ALL", "en"]] + @regions
    @notification.localized_notifications.append(Notifiable::LocalizedNotification.new)
  end

  def create
    @notification.app = @app    

    if @notification.save
      if @user
        @notification.delay_private(@user,  run_at) 
      elsif device_token_filter_params?
        @notification.delay_filtered(device_token_filter_params, run_at)     
      else
        @notification.delay_public(run_at)               
      end
      
      redirect_to admin_account_app_jobs_path(@account, @app), notice: "Notification(s) sent successfully"
    else
      redirect_to new_admin_account_app_notification_path(@account, @app, @notification), notice: "Notification(s) not sent successfully"
    end

    
  end
  
  def index
    @notifications = @notifications.includes(:localized_notifications)
    @notifications = @notifications.order!('notifiable_notifications.created_at DESC').page(params[:page])
  end
  
  private
    def run_at
      !params[:schedule_at] || params[:schedule_at].empty? ? DateTime.now : DateTime.strptime(params[:schedule_at], "%m/%d/%Y %H:%M %p")
    end
    
    def find_user
      @user = NotifiableAdmin::User.find(params[:notification].delete(:user_id)) if params[:notification] && params[:notification][:user_id]
    end
    
    def device_token_filter_params
      params[:notification][:device_token_filters]
    end
    
    def device_token_filter_params?
      return false unless device_token_filter_params
      device_token_filter_params.each_pair do |k,v|
        return true unless device_token_filter_params[k].empty?
      end
      
      false
    end
    
    def create_params
      params.require(:notification).permit(localized_notifications_attributes: [:message, :locale, :params]).tap do |whitelisted|
      
        # whitelist any params
        whitelisted[:localized_notifications_attributes].each_pair do |index, item|
          item[:params] = params[:notification][:localized_notifications_attributes][index][:params]
        end
      end
    end
    
    def parse_params
      params[:notification][:localized_notifications_attributes].each_pair do |index, localized_notification_attributes|
        localized_notification_attributes[:params] = Rack::Utils.parse_nested_query(localized_notification_attributes[:params])
      end
    end
end