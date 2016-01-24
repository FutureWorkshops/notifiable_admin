module NotifiableAdmin::ApplicationHelper
  
  # Building blocks
  def navbar_item(name, path, active = false, method = :get)
    html_options = active ? {:class => :active} : {}
    content_tag("li", link_to(name, path, :method => method), html_options)
  end
  
  def button(path, text, icon, method = :get, size = :sm, data = nil)
    link_to raw("<span class='glyphicon glyphicon-#{icon}'></span> #{text}"), path, :class => "btn btn-default btn-#{size}", :method => method, :data => data
  end
  
  def copy_button(id, title, text)
    button_tag title, data: { clipboard_text: text }, id: id, class: "btn btn-default btn-sm"
  end
  
  def add_button(path)
    button path, "Add", "plus", :get, nil    
  end
  
  def delete_button(path, text = "Delete")
    button path, text, "trash", :delete, :sm, { confirm: "Are you sure?" }
  end
  
  def danger_label(text, options = {})
    content_tag("span", text, {:class => "label label-danger"}.merge!(options))    
  end
  
  # Buttons
  def enable_notifications_api_user_button(user)
    button enable_admin_account_notifications_api_user_path(user.account, user), "Enable", "ok-circle", :put
  end
  
  def disable_notifications_api_user_button(user)
    button disable_admin_account_notifications_api_user_path(user.account, user), "Disable", "ban-circle", :put
  end
      
  def public_notification_button(app)
    button new_admin_account_app_notification_path(@account, app), "Send Public Notification", "bullhorn"
  end
  
  def user_notification_button(app, user)
    button new_admin_account_app_user_notification_path(@account, app, user), "Send Notification", "envelope"
  end
  
  def notification_statuses_button(notification)
    button admin_account_app_notification_notification_statuses_path(@account, notification.app, notification), "Receipts", "ok-circle"
  end
  
  def new_app_button
    button new_admin_account_app_path(@account), "New App", "plus"
  end
  
  def edit_app_button(app)
    button edit_admin_account_app_path(@account, app), "Edit", "pencil"
  end
  
  # Navbar items
  def super_admin_accounts_navbar_item
    navbar_item("Accounts", super_admin_accounts_path, params[:controller] == "super_admin/accounts" && params[:action] == "index")
  end
    
  def device_tokens_navbar_item
    navbar_item("Device Tokens", @app.new_record? ? "/" : admin_app_device_tokens_path(@app), params[:controller] == "admin/device_tokens" && params[:action] == "index")    
  end
  
  def notifications_navbar_item
    navbar_item("Sent", admin_account_app_notifications_path(@account, @app), params[:controller] == "admin/notifications" && params[:action] == "index")
  end
  
  def app_users_navbar_item
    navbar_item("Devices", admin_account_app_device_tokens_path(@account, @app), params[:controller] == "admin/device_tokens" && params[:action] == "index")
  end
  
  def app_jobs_navbar_item
    navbar_item("Scheduled", admin_account_app_jobs_path(@account, @app), params[:controller] == "admin/jobs" && params[:action] == "index")    
  end
  
  def admins_navbar_item
    navbar_item("Users", admin_account_admins_path(@account), params[:controller] == "admin/admin" && params[:action] == "index")
  end
  
  def new_app_navbar_item
    navbar_item("New App", new_admin_account_app_path(@account), params[:controller] == "admin/apps" && params[:action] == "new")
  end
  
  def edit_app_navbar_item
    navbar_item("Settings", edit_admin_account_app_path(@account, @app), params[:controller] == "admin/apps" && params[:action] == "edit")
  end

  def notification_api_keys_navbar_item
    navbar_item("Notification API Keys", admin_account_notifications_api_users_path(@account), params[:controller] == "admin/notifications_api_users" && params[:action] == "index")   
  end
  
  def user_api_keys_navbar_item
    navbar_item("User API Keys", admin_account_user_api_users_path(@account), params[:controller] == "admin/user_api_users" && params[:action] == "index")   
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
  
  def app_send_public_notification_navbar_item
    navbar_item "Compose", new_admin_account_app_notification_path(@account, @app)
  end
  
  # Paths
  def new_admin_account_app_user_notification_path(account, app, user)
    "#{new_admin_account_app_notification_path(account, app)}?notification[user_id]=#{user.id}"
  end
  
  
end
