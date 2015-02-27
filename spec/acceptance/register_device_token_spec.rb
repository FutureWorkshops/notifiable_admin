require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "DeviceToken" do
  header "Content-Accept", "application/json"
  
  let(:notifiable_app) { FactoryGirl.create(:app) }
  
  post "/user_api/v1/device_tokens" do
    parameter :alias, "Username/Alias", :required => true, :scope => :user
    parameter :provider, "Provider", :required => true
    parameter :token, "Token", :required => true
    parameter :app_id, "App ID", :required => true
    parameter :locale, "Locale"
    
    let(:alias) { "broomba" }
    let(:provider) { 'apns' }
    let(:token) { "ABC123" }
    let(:app_id) { notifiable_app.id }
    let(:locale) { 'en' }
    
    example_request "Register an iOS device", :document => :user_api do
      status.should == 200
    end
    
  end
end