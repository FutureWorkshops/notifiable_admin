class NotifiableAdmin::Admin::AccountsController < NotifiableAdmin::Admin::BaseController

  load_and_authorize_resource :account, :class => "NotifiableAdmin::Account"  

end