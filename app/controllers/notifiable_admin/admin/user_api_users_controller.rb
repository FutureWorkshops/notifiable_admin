class NotifiableAdmin::Admin::UserApiUsersController < NotifiableAdmin::Admin::BaseController

  load_and_authorize_resource :user_api_user, :class => "NotifiableAdmin::UserApiUser"
  
  def index
    @user_api_users = @user_api_users.page(params[:page])
  end

  def create
    @user_api_user.save ? notice_redirect_to_index("Key created") : alert_redirect_to_new
  end
  
  def destroy    
    @user_api_user.delete ? notice_redirect_to_index("Key deleted") : alert_redirect_to_index
  end
  
  private
    def create_params
      params.require(:user_api_user).permit(:service_name, :app_id)
    end
    
    def notice_redirect_to_index(notice)
      redirect_to admin_account_user_api_users_path(@account), notice: notice
    end
    
    def alert_redirect_to_index
      redirect_to admin_account_user_api_users_path(@account), alert: @notifications_api_user.errors.full_messages.to_sentence
    end
    
    def alert_redirect_to_new
      redirect_to new_admin_account_user_api_user_path(@account, @user_api_user), alert: @user_api_user.errors.full_messages.to_sentence
    end
  

end