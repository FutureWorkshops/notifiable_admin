require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "NotificationStatus" do
  header "Content-Accept", "application/json"
  header "X-Auth-Token", :auth_token
  
  let(:account) { create(:account) }
  let(:user) { create(:user) }
  let(:notifiable_app) { create(:app, :account => account) }  
  let(:device_token) { create(:apns_token, :app => notifiable_app, :user_id => user.id, :locale => :en)}
  let(:notification) { create(:notification, :app => notifiable_app)}
  let(:localized_notification) { create(:localized_notification)}
  let(:status) {  }
  
  before(:each){ ApiAuthHelpers.set_credentials(notifiable_app.access_id, notifiable_app.secret_key) }
  
  put "/user_api/v1/notification_statuses/opened" do
    parameter :alias, "App Username", :required => true, :scope => :user
    parameter :localized_notification_id, "Localized Notification ID", :required => true
    parameter :device_token_id, "Device Token ID", :required => true
    
    let(:alias) { user.alias }
    let(:localized_notification_id) { localized_notification.id }
    let(:device_token_id) { device_token.id }
    
    example "Mark a notification as opened", :document => :user_api do
      create(:notification_status, :localized_notification => localized_notification, :device_token => device_token)
      
      do_request
      
      expect(status).to eq 200
      expect(Notifiable::NotificationStatus.first.opened?).to eq true
    end
    
  end
end

