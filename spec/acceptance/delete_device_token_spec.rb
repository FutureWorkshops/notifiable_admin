require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "DeviceToken" do
  header "Content-Accept", "application/json"
  
  header "X-Auth-Token", :auth_token
  
  let(:account) { create(:account) }
  let(:user) { create(:user, :alias => "broomba", app: n_app) }
  let(:n_app) { FactoryGirl.create(:app) }
  let(:api_user) { FactoryGirl.create(:user_api_user, :app => n_app) }
  let(:device_token) { create(:apns_token, :app => n_app, :user_id => user.id)}
  
  before(:each) { ApiAuthHelpers.set_credentials(api_user.access_id, api_user.secret_key) } 
  
  delete "/user_api/v1/device_tokens/:device_token_id" do
    parameter :alias, "Username/Alias", :required => true, :scope => :user
    
    let(:alias) { user.alias }
    let(:device_token_id) { device_token.id }
    
    example_request "Delete a device", :document => :user_api do
      expect(status).to eql 200
      expect(Notifiable::DeviceToken.count).to eql 0
    end
    
  end
end