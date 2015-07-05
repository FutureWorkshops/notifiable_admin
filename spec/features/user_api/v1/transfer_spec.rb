require 'rails_helper'

feature 'transfers a token' do

  let(:notifiable_app) { FactoryGirl.create(:app) }
  let(:anonymous_device_token) { FactoryGirl.create(:gcm_token) }
  let(:user_with_token) { FactoryGirl.create(:user_with_gcm_token) }
  let(:device_token) { user_with_token.device_tokens.first }

  it "to a user" do   
    post user_api_v1_device_token_path(anonymous_device_token), :user => {:alias => "12345678910"}
  
    User.count.should == 1
    u = User.first
    u.alias.should eql "12345678910"
    u.device_tokens.count.should == 1

    Notifiable::DeviceToken.count.should == 1    
    dt = u.device_tokens.first
    dt.token.should eql anonymous_device_token.token
    dt.provider.should eql anonymous_device_token.provider
  end  
  
  it "to anonymous" do 
    post user_api_v1_device_token_path(device_token)
           
    User.count.should == 1
    u = User.first
    u.device_tokens.count.should == 0

    Notifiable::DeviceToken.count.should == 1    
    dt = Notifiable::DeviceToken.first
    dt.token.should eql 'ABC12345678910'
    dt.provider.should eql 'apns'
  end
  
end

