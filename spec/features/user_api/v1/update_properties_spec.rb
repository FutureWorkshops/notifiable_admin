require 'rails_helper'

feature 'update device token' do
  
  let(:notifiable_app) { FactoryGirl.create(:app) }
  let(:user_with_token) { FactoryGirl.create(:user_with_gcm_token) }
  let(:device_token) { user_with_token.device_tokens.first }
  
  it "for the token" do  
    put user_api_v1_device_token_path(device_token), :id => device_token.id, :user => {:alias => device_token.user.alias}, :provider => 'gcm', :token => 'AAA12345678910', :app_id => notifiable_app.id
        
    User.count.should == 1
    u = User.first
    u.device_tokens.count.should == 1

    Notifiable::DeviceToken.count.should == 1    
    dt = u.device_tokens.first
    dt.token.should eql "AAA12345678910"
    dt.provider.should eql "gcm"
  end
  
end
  