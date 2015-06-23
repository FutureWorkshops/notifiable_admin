require 'rails_helper'

feature 'register a device token' do
  
  let(:notifiable_app) { create(:app) }
  let(:u2) { create(:user) }
  let(:user_with_token) { create(:user_with_gcm_token) }
  let(:device_token) { user_with_token.device_tokens.first }
  
  before(:each){ ApiAuthHelpers.set_credentials(notifiable_app.access_id, notifiable_app.secret_key) }
  
  it "for new token" do 
    post notifiable_admin.user_api_v1_device_tokens_path, :provider => 'apns', :token => 'ABC12345678910', :device_id => "DEF567", :app_id => notifiable_app.id

    expect(NotifiableAdmin::User.count).to eq 0
    expect(Notifiable::DeviceToken.count).to eq 1 
    expect(Notifiable::DeviceToken.first.token).to eq 'ABC12345678910'    
    expect(Notifiable::DeviceToken.first.provider).to eq 'apns'    
  end
  
  it "for a new device token and new user" do 
    post notifiable_admin.user_api_v1_device_tokens_path, :user => {:alias => "12345678910"}, :provider => 'apns', :token => 'ABC12345678910', :app_id => notifiable_app.id
    
    expect(NotifiableAdmin::User.count).to eq 1
    expect(NotifiableAdmin::User.first.alias).to eq "12345678910"
    expect(NotifiableAdmin::User.first.device_tokens.count).to eq 1

    expect(Notifiable::DeviceToken.count).to eq 1  
    expect(NotifiableAdmin::User.first.device_tokens.first.token).to eq 'ABC12345678910'  
    expect(NotifiableAdmin::User.first.device_tokens.first.provider).to eq 'apns'
  end
  
  it "for an existing user" do     
    post notifiable_admin.user_api_v1_device_tokens_path, :user => {:alias => u2.alias}, :provider => 'apns', :token => 'ABC123', :app_id => notifiable_app.id

    expect(NotifiableAdmin::User.count).to eq 1
    expect(NotifiableAdmin::User.first.alias).to eq u2.alias
    expect(NotifiableAdmin::User.first.device_tokens.count).to eq 1
    expect(Notifiable::DeviceToken.count).to eq 1  
    expect(NotifiableAdmin::User.first.device_tokens.first.token).to eq "ABC123"
    expect(NotifiableAdmin::User.first.device_tokens.first.provider).to eq 'apns'
  end
  
end