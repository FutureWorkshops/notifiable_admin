class NotifiableAdmin::Admin::AppsController < NotifiableAdmin::Admin::BaseController
  
  load_and_authorize_resource :class => "Notifiable::App"

  def create
    @app.account = @account
    if @app.save
      redirect_to admin_account_app_path(@account, @app), notice: "App was created."
    else
      redirect_to new_admin_account_app_path(@account, @app), alert: @app.errors.full_messages.to_sentence
    end
  end
      
  def update
    if @app.update_attributes(app_params)
      redirect_to admin_account_app_path(@account, @app), notice: "App was updated."
    else
      redirect_to edit_admin_account_app_path(@account, @app), alert: @app.errors.full_messages.to_sentence
    end
  end
  
  def show
    @days = 60
  end
  
  private 
    def app_params
      params.require(:app).permit(:name, :apns_certificate, :apns_passphrase, :apns_sandbox, :gcm_api_key)
    end
  
end