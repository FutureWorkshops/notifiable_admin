class NotifiableAdmin::SuperAdmin::AccountsController < NotifiableAdmin::SuperAdmin::BaseController

  load_and_authorize_resource :account, :class => "NotifiableAdmin::Account"
    
  def index
    @accounts = @accounts.page(params[:page])
  end
  
  def create
    if @account.save
      NotifiableAdmin::Admin.invite!(invite_params, current_admin) do |invitable|
        invitable.account = @account
        invitable.role = "account_owner"
      end
      redirect_to super_admin_accounts_path, notice: "Account created."
    else
      redirect_to new_super_admin_account_path(@account), alert: @account.errors.full_messages.to_sentence
    end
  end
  
  private
    def create_params
      params.require(:account).permit(:name)
    end
    
    def invite_params
      params.require(:account_owner).permit(:email)
    end
end