require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "DeviceToken" do
  header "Content-Accept", "application/json"
  
  header "X-Auth-Token", :auth_token
  
  let(:account) { create(:account) }
  let(:user) { create(:user, :alias => "broomba") }
  let(:notifiable_app) { create(:app, :account => account) }  
  let(:device_token) { create(:apns_token, :app => notifiable_app, :user_id => user.id)}
  
  before(:each){ ApiAuthHelpers.set_credentials(notifiable_app.access_id, notifiable_app.secret_key) }
  
  delete "/user_api/v1/device_tokens/:device_token_id" do
    parameter :alias, "Username/Alias", :required => true, :scope => :user
    
    let(:alias) { "broomba" }
    let(:device_token_id) { device_token.id }
    
    example_request "Delete a device", :document => :user_api do
      expect(status).to eql 200
      expect(Notifiable::DeviceToken.count).to eql 0
    end
    
  end
end