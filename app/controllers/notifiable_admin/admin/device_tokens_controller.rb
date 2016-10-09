class NotifiableAdmin::Admin::DeviceTokensController <NotifiableAdmin::Admin::BaseController

  load_and_authorize_resource :app, :class => "Notifiable::App"
  load_and_authorize_resource :device_token, :class => "Notifiable::DeviceToken", :through => :app

  def index
    @device_tokens = @device_tokens.where(:is_valid => true).page(params[:page])
  end
  
  def destroy_all
    @app.device_tokens.destroy_all
    flash[:notice] = "All #{@app.name} devices have been deleted."
    redirect_to edit_admin_account_app_path(@app.account, @app)
  end
  
end