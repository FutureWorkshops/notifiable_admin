require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Notification" do
  header "Content-Accept", "application/json"

  let(:account) { create(:empty_account) }
  let(:n_app) { FactoryGirl.create(:app) }
  let(:api_user) { FactoryGirl.create(:user_api_user, :app => n_app) }
    
  before(:each) { ApiAuthHelpers.set_credentials(api_user.access_id, api_user.secret_key) }
  
  get "/user_api/v1/device_tokens.json" do
    let!(:user) { create(:user, :alias => "123456789", app: n_app) }
    let!(:token) { create(:apns_token, :app => n_app, :user_id => user.id)}
    let(:raw_post) { {:user => {:alias => user.alias}} }
    
    example "List device tokens for user", :document => :user_api do
      do_request
      expect(status).to eq 200
    end
  end
  
end