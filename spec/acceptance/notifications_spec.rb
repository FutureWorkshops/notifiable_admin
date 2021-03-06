require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Notification" do
  header "Content-Accept", "application/json"

  let(:account) { create(:account) }
  let(:notifiable_app) { create(:app, :account => account, :custom_device_properties => [:onsite]) }  
  let(:notifications_api_user) { create(:notifications_api_user, :apps => [notifiable_app], :account => account) }
  
  before(:each) do
    ApiAuthHelpers.set_credentials(notifications_api_user.access_id, notifications_api_user.secret_key)
  end
  
  post "/notifications_api/v1/notifications" do    
    let!(:token) { create(:apns_token, :app => notifiable_app, :locale => :en)}
    
    let(:raw_post) {{:app_id => notifiable_app.id, :notification => {:localized_notifications_attributes => [{:message => "Hello", :locale => :en}]}}}
    
    example "Notify everybody", :document => :notifications_api do
      do_request
      expect(status).to eq 200
      expect(Notifiable::Notification.count).to eq 1
      expect(Notifiable::NotificationStatus.count).to eq 1
    end
  end
  
  post "/notifications_api/v1/notifications" do    
    let!(:token) { create(:apns_token, :app => notifiable_app, :locale => :en)}
    let(:raw_post) {{:app_id => notifiable_app.id, :notification => {:localized_notifications_attributes => [{:message => "Hello", :locale => :en, :params => {:test_param => "abc123"}}]}}}
    
    example_request "Notify everybody using notification params", :document => :notifications_api do
      expect(status).to eq 200
      expect(Notifiable::Notification.count).to eq 1
      expect(Notifiable::NotificationStatus.count).to eq 1
      expect(Notifiable::Notification.first.localized_notifications.first.params['test_param']).to eq "abc123"
    end
  end
  
  post "/notifications_api/v1/notifications" do    
    let!(:token1) { create(:apns_token, :app => notifiable_app, :locale => :en, :custom_properties => {:onsite => "1"})}
    let!(:token2) { create(:apns_token, :app => notifiable_app, :locale => :en, :custom_properties => {:onsite => "0"})}
    
    let(:raw_post) {{
      :app_id => notifiable_app.id, 
      :notification => {
        device_token_filters_attributes: [{property: "onsite", operator: "=", value: "1"}],
        localized_notifications_attributes: [{:message => "Hello", :locale => :en}]}
    }}
    
    example_request "Notify devices via a custom property", :document => :notifications_api do
      expect(status).to eq 200
      expect(Notifiable::Notification.count).to eq 1
      expect(Notifiable::NotificationStatus.count).to eq 1
    end
  end
  
  post "/notifications_api/v1/notifications" do    
    let!(:token1) { create(:apns_token, :app => notifiable_app, :locale => :en, :custom_properties => {:onsite => ["0", "1"]})}
    let!(:token2) { create(:apns_token, :app => notifiable_app, :locale => :en, :custom_properties => {:onsite => ["0", "2"]})}
    
    let(:raw_post) {{
      :app_id => notifiable_app.id, 
      :notification => {
        device_token_filters_attributes: [{property: "onsite", operator: "LIKE", value: "1"}],
        localized_notifications_attributes: [{:message => "Hello", :locale => :en}]}
    }}
    
    example_request "Notify devices via a custom property", :document => :notifications_api do
      expect(status).to eq 200
      expect(Notifiable::Notification.count).to eq 1
      expect(Notifiable::NotificationStatus.count).to eq 1
    end
  end
  
  post "/notifications_api/v1/notifications" do
    parameter :message, "Message", :required => true, :scope => :notification
    parameter :app_id, "App ID", :required => true
    parameter :alias, "User Alias", :scope => :user, :required => true
    
    let(:user) { create(:user)}
    let!(:token) { create(:apns_token, :app => notifiable_app, :locale => :en, :user_id => user.id)}
    
    let(:raw_post) {{:alias => user.alias, :app_id => notifiable_app.id, :notification => {:app_id => notifiable_app.id, :localized_notifications_attributes => [{:message => "Hello", :locale => :en}]}}}
    
    example_request "Notify a single", :document => :notifications_api do
      expect(status).to eql 200    
      expect(Notifiable::NotificationStatus.count).to eql 1  
    end
  end
  
end

