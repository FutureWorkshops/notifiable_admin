class NotifiableAdmin::Admin::NotificationsApiUsersController < NotifiableAdmin::Admin::BaseController

  load_and_authorize_resource :notifications_api_user, :class => "NotifiableAdmin::NotificationsApiUser"
  
  def index
    @notifications_api_users = @notifications_api_users.page(params[:page])
  end

  def create
    if @notifications_api_user.save
      redirect_to admin_account_notifications_api_users_path(@account), notice: "Notifications API Key created."
    else
      redirect_to new_admin_account_notifications_api_user_path(@account), alert: @notifications_api_user.errors.full_messages.to_sentence
    end
  end
  
  def destroy
    @notifications_api_user = NotifiableAdmin::NotificationsApiUser.find(params[:id])
    
    if @notifications_api_user.delete
      redirect_to admin_account_notifications_api_users_path(@account), notice: "Notifications API Key deleted."      
    else
      redirect_to admin_account_notifications_api_users_path(@account), alert: @notifications_api_user.errors.full_messages.to_sentence
    end
  end
  
  private
    def create_params
      params.require(:notifications_api_user).permit(:service_name, :app_ids => [])
    end
  

end