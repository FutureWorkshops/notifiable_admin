class NotifiableAdmin::Admin::NotificationsApiUsersController < NotifiableAdmin::Admin::BaseController

  load_and_authorize_resource :notifications_api_user, :class => "NotifiableAdmin::NotificationsApiUser"
  
  def index
    @notifications_api_users = @notifications_api_users.page(params[:page])
  end

  def create
    @notifications_api_user.account = @account
    @notifications_api_user.save ? notice_redirect_to_index("Key created") : alert_redirect_to_new
  end
  
  def destroy    
    @notifications_api_user.destroy ? notice_redirect_to_index("Key deleted") : alert_redirect_to_index
  end
  
  def enable
    @notifications_api_user.enable ? notice_redirect_to_index("Key enabled") : alert_redirect_to_index
  end
  
  def disable
    @notifications_api_user.disable ? notice_redirect_to_index("Key disabled") : alert_redirect_to_index    
  end
  
  def require_authorization
    @notifications_api_user.require_authorization ? notice_redirect_to_index("Authorization enabled") : alert_redirect_to_index
  end
  
  def dont_require_authorization
    @notifications_api_user.dont_require_authorization ? notice_redirect_to_index("Authorization disabled") : alert_redirect_to_index    
  end
  
  private
    def notice_redirect_to_index(notice)
      redirect_to admin_account_notifications_api_users_path(@account), notice: notice
    end
    
    def alert_redirect_to_index
      redirect_to admin_account_notifications_api_users_path(@account), alert: @notifications_api_user.errors.full_messages.to_sentence
    end
    
    def alert_redirect_to_new
      redirect_to new_admin_account_notifications_api_user_path(@account, @notifications_api_user), alert: @notifications_api_user.errors.full_messages.to_sentence
    end
  
    def create_params
      params.require(:notifications_api_user).permit(:service_name, :app_ids => [])
    end
end