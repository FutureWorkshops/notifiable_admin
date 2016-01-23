require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "DeviceToken" do
  header "Content-Accept", "application/json"
  
  let(:n_app) { FactoryGirl.create(:app) }
  let(:api_user) { FactoryGirl.create(:user_api_user, :app => n_app) }
  
  before(:each){ ApiAuthHelpers.set_credentials(api_user.access_id, api_user.secret_key) }
  
  post "/user_api/v1/device_tokens" do
    parameter :alias, "Username/Alias", :required => true, :scope => :user
    parameter :provider, "Provider", :required => true
    parameter :token, "Token", :required => true
    parameter :app_id, "App ID", :required => true
    parameter :locale, "Locale"
    parameter :name, "The user's name for the device"
    
    let(:alias) { "broomba" }
    let(:provider) { 'apns' }
    let(:token) { "ABC123" }
    let(:app_id) { n_app.id }
    let(:locale) { 'en' }
    let(:locale) { "Matt's iPhone" }
    
    example_request "Register an iOS device", :document => :user_api do
      expect(status).to eql 200
    end
    
  end
end