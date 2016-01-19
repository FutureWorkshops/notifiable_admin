class NotifiableAdmin::UserApi::V1::DeviceTokensController < NotifiableAdmin::UserApi::V1::BaseController

  before_filter :create_user, :only => [:create, :update], :unless => :current_notifiable_user?
  before_filter :find_device_token!, :ensure_authorized!, :except => [:create, :index]
  before_filter :ensure_current_notifiable_user!, :only => :index
  
  def create
    @device_token = Notifiable::DeviceToken.find_or_initialize_by(:token => params[:token], :app_id => @app.id)
    @device_token.is_valid = true
    @device_token.user_id = current_notifiable_user
    
    if @device_token.update_attributes(device_token_params)
      render :json => @device_token.to_json(:only => [ :id ] ), :status => :ok
    else
      render :json => { :errors => @device_token.errors.full_messages }, :status => :unprocessable_entity
    end
  end
  
  def update
    @device_token.user_id = current_notifiable_user
    if @device_token.update_attributes(device_token_params)
      render :json => @device_token.to_json(:only => [ :id ] ), :status => :ok
    else
      render :json => { :errors => @device_token.errors.full_messages }, :status => :unprocessable_entity
    end
  end

  def destroy    
    if @device_token.destroy
      head :status => :ok
    else
      render :json => { :errors => @device_token.errors.full_messages }, :status => :unprocessable_entity
    end
  end
  
  def index
    @device_tokens = current_notifiable_user.device_tokens
  end
  
  private
    def create_user
      @current_api_v1_user = NotifiableAdmin::User.create(:alias => params[:user][:alias]) if params[:user] && params[:user][:alias]
    end
  
    def device_token_params
      device_token_params = params.permit(Notifiable.api_device_token_params)
      
      if current_notifiable_user
        device_token_params[:user_id] = current_notifiable_user.id 
      else
        device_token_params[:user_id] = nil   
      end

      device_token_params
    end
    
    def ensure_current_notifiable_user!
      head :status => :not_found unless current_notifiable_user
    end
  
    def ensure_authorized!
      head :status => :unauthorized unless !@device_token.user || @device_token.user.eql?(current_notifiable_user)
    end
  
    def find_device_token!
      @device_token = Notifiable::DeviceToken.find_by_id_and_app_id!(params[:id], @app.id)
    end
end
