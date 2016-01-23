class NotifiableAdmin::Admin::UserApiUsersController < NotifiableAdmin::Admin::BaseController

  load_and_authorize_resource :user_api_user, :class => "NotifiableAdmin::UserApiUser"
  
  def index
    @user_api_users = @user_api_users.page(params[:page])
  end

  def create
    if @user_api_user.save
      redirect_to admin_account_user_api_users_path(@account), notice: "User API Key created."
    else
      redirect_to new_admin_account_user_api_user_path(@account), alert: @user_api_user.errors.full_messages.to_sentence
    end
  end
  
  def destroy    
    if @user_api_user.delete
      redirect_to admin_account_user_api_users_path(@account), notice: "User API Key deleted."      
    else
      redirect_to admin_account_user_api_users_path(@account), alert: @user_api_user.errors.full_messages.to_sentence
    end
  end
  
  private
    def create_params
      params.require(:user_api_user).permit(:service_name, :app_id)
    end
  

end