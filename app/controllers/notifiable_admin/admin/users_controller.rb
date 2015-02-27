class NotifiableAdmin::Admin::UsersController < NotifiableAdmin::Admin::BaseController

  load_and_authorize_resource :app, :class => "Notifiable::App"

  before_filter :find_users, :only => :index
  load_and_authorize_resource :user, :class => "NotifiableAdmin::User"
  

  def index
    @users = @users.page(params[:page])
  end
  
  private
    def find_users
      @users = NotifiableAdmin::User.for_app(@app)    
    end
  
end