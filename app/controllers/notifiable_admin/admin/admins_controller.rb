class NotifiableAdmin::Admin::AdminsController < NotifiableAdmin::Admin::BaseController

  load_and_authorize_resource :class => "NotifiableAdmin::Admin"
  
  def index
    @admins = @admins.page(params[:page])
  end

  def create
    @admin.account = @account
    if @admin.save
      redirect_to admin_account_admins_path(@account), notice: "User created."
    else
      redirect_to new_admin_account_admin_path(@account, @admin), alert: @admin.errors.full_messages.to_sentence
    end
  end
  
  def destroy    
    if @admin.delete
      redirect_to admin_account_admins_path(@account), notice: "User deleted."      
    else
      redirect_to admin_account_admins_path(@account), alert: @admin.errors.full_messages.to_sentence
    end
  end
  
  private
    def create_params
      params.require(:admin).permit(:email, :password, :role, :app_ids => [])
    end

end