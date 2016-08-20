require 'rails_helper'

feature 'Send private notifications' do
  
  let(:request_headers) { {'HTTP_ACCEPT' => "application/json"} }
  
  let(:account) { create(:account) }  
  let(:notifiable_app) { create(:app, :account => account) }
  let(:notifications_api_user) { create(:notifications_api_user, :apps => [notifiable_app], :account => account) }
  let(:notifiable_app2) { create(:app) }
  let(:user) { create(:user, app: notifiable_app) { |user| create(:apns_token, :app_id => notifiable_app.id, :user_id => user.id, :locale => :en) }}

  scenario "to a valid user" do    
    ApiAuthHelpers.set_credentials(notifications_api_user.access_id, notifications_api_user.secret_key)
    
    post notifiable_admin.notifications_api_v1_notifications_path, {:user => {:alias => user.alias}, :app_id => notifiable_app.id, :notification => {:localized_notifications_attributes => [{:message => "Hello", :locale => :en}]}}, request_headers

    expect(response.status).to eq 200
    expect(Notifiable::NotificationStatus.count).to eq 1
    expect(Notifiable::NotificationStatus.first.localized_notification.message).to eq "Hello"
    expect(Notifiable::NotificationStatus.first.device_token).to eq user.device_tokens.first
  end

  it "fails when when no credentials are provided" do 
    ApiAuthHelpers.set_credentials(nil, nil)
    
    post notifiable_admin.notifications_api_v1_notifications_path, nil, request_headers
    expect(response.status).to eq 403
  end
  
  it "fails when invalid credentials are provided" do
    ApiAuthHelpers.set_credentials(notifications_api_user.access_id, "INVALID SECRET KEY")
     
    post notifiable_admin.notifications_api_v1_notifications_path, {:token => "ABC1234"}, request_headers
    expect(response.status).to eq 403
  end
  
  it "fails when not authorised" do 
    ApiAuthHelpers.set_credentials(notifications_api_user.access_id, notifications_api_user.secret_key)
      
    post notifiable_admin.notifications_api_v1_notifications_path, {:app_id => notifiable_app2.id, :user => {:alias => user.alias}, :notification => {:message => "Test"}}, request_headers

    expect(response.status).to eq 401
    expect(Notifiable::NotificationStatus.count).to eq 0
  end
  

  
end