module NotifiableAdmin::ApplicationHelper
  
  def current_app
    return nil if current_admin.super_admin?
    
    params[:app_id] ? @app : current_admin.account.apps.first
  end
  
  # Building blocks
  def navbar_item(name, path, active = false, method = :get)
    html_options = active ? {:class => :active} : {}
    content_tag("li", link_to(name, path, :method => method), html_options)
  end
  
  def button(path, text, icon, method = :get, size = :sm, data = nil)
    link_to raw("<span class='glyphicon glyphicon-#{icon}'></span> #{text}"), path, :class => "btn btn-default btn-#{size}", :method => method, :data => data
  end
  
  def add_button(path)
    button path, "Add", "plus", :get, nil    
  end
  
  def delete_button(path, text = "Delete")
    button path, text, "trash", :delete, :sm, { confirm: "Are you sure?" }
  end
  
  # Buttons    
  def public_notification_button(app)
    button new_admin_account_app_notification_path(@account, app), "Send Public Notification", "bullhorn"
  end
  
  def user_notification_button(app, user)
    button new_admin_account_app_user_notification_path(@account, app, user), "Send Private Notification", "envelope"
  end
  
  def notification_statuses_button(notification)
    button admin_account_app_notification_notification_statuses_path(@account, notification.app, notification), "Receipts", "ok-circle"
  end
  
  def edit_app_button(app)
    button edit_admin_account_app_path(@account, app), "Edit", "pencil"
  end
  
  # Navbar items
  def super_admin_accounts_navbar_item
    navbar_item("Accounts", super_admin_accounts_path, params[:controller] == "super_admin/accounts" && params[:action] == "index")
  end
    
  def device_tokens_navbar_item(current_app)
    navbar_item("Device Tokens", current_app.new_record? ? "/" : admin_app_device_tokens_path(current_app), params[:controller] == "admin/device_tokens" && params[:action] == "index")    
  end
  
  def notifications_navbar_item
    navbar_item("Notifications", admin_account_app_notifications_path(@account, current_app), params[:controller] == "admin/notifications" && params[:action] == "index")
  end
  
  def app_users_navbar_item
    navbar_item("App Users", admin_account_app_users_path(@account, current_app), params[:controller] == "admin/users" && params[:action] == "index")
  end
  
  def app_jobs_navbar_item
    navbar_item("Schedule", admin_account_app_jobs_path(@account, current_app), params[:controller] == "admin/jobs" && params[:action] == "index")    
  end
  
  def admins_navbar_item
    navbar_item("Account Users", admin_account_admins_path(@account), params[:controller] == "admin/admin" && params[:action] == "index")
  end
  
  def new_app_navbar_item
    navbar_item("Create New App", new_admin_account_app_path(@account), params[:controller] == "admin/apps" && params[:action] == "new")
  end
  
  def edit_app_navbar_item
    navbar_item("App Settings", edit_admin_account_app_path(@account, @app), params[:controller] == "admin/apps" && params[:action] == "edit")
  end

  def api_keys_navbar_item
    navbar_item("API Keys", admin_account_notifications_api_users_path(@account), params[:controller] == "admin/notifications_api_users" && params[:action] == "index")   
  end
  
  def api_documentation_navbar_item
    navbar_item("API Documentation", admin_account_api_docs_path(@account), params[:controller] == "admin/api_docs" && params[:action] == "index")
  end
  
  def logout_navbar_item
    navbar_item("Log Out", destroy_admin_session_path, false, :delete)
  end
  
  def app_navbar_item(app)
    navbar_item(app.name, admin_account_app_path(@account, app), params[:controller] == "admin/apps" && params[:action] == "show" && params[:id].to_i == app.id)
  end
  
  # Paths
  def new_admin_account_app_user_notification_path(account, app, user)
    "#{new_admin_account_app_notification_path(account, app)}?notification[user_id]=#{user.id}"
  end
  
  
end
