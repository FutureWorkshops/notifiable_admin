class NotifiableAdmin::Admin::DeviceTokensController <NotifiableAdmin::Admin::BaseController

  load_and_authorize_resource :app, :class => "Notifiable::App"
  load_and_authorize_resource :device_token, :class => "Notifiable::DeviceToken", :through => :app

  def index
    @device_tokens = @device_tokens.where(:is_valid => true).page(params[:page])
  end
  
end