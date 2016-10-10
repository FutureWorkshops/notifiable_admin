require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "NotificationStatus" do
  header "Content-Accept", "application/json"
  
  let(:account) { create(:account) }
  let(:n_app) { create(:app) }
  let(:user) { create(:user, app: n_app) }
  let(:api_user) { create(:user_api_user, :app => n_app) }
  let(:device_token) { create(:apns_token, :app => n_app, :user_id => user.id, :locale => :en)}
  let(:notification) { create(:notification, :app => n_app)}
  let(:localized_notification) { create(:localized_notification)}
  let!(:ln_status) { create(:notification_status, :localized_notification => localized_notification, :device_token => device_token) }
  
  before(:each) { ApiAuthHelpers.set_credentials(api_user.access_id, api_user.secret_key) } 
  
  put "/user_api/v1/notification_statuses/opened" do
    parameter :alias, "App Username", :required => true, :scope => :user
    parameter :localized_notification_id, "Localized Notification ID", :required => true
    parameter :device_token_id, "Device Token ID", :required => true
    
    let(:alias) { user.alias }
    let(:localized_notification_id) { localized_notification.id }
    let(:device_token_id) { device_token.id }
    
    example "Mark a notification as opened", :document => :user_api do
      do_request
      
      expect(status).to eq 200
      expect(Notifiable::NotificationStatus.first.opened?).to eq true
    end
    
  end
end

