class NotifiableAdmin::Admin::SessionsController < ::Devise::SessionsController
  layout "admin_sessions"
  
  def after_sign_in_path_for(admin)
    if admin.super_admin?
      super_admin_accounts_path
    else
      notifiable_admin.admin_account_app_path(admin.account, admin.default_app)      
    end
  end

  def after_sign_out_path_for(admin)
    new_admin_session_path
  end
end