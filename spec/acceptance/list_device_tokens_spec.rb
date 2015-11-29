require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Notification" do
  header "Content-Accept", "application/json"

  let(:account) { create(:empty_account) }
  let(:notifiable_app) { create(:app, :account => account) }  
  
  before(:each) { ApiAuthHelpers.set_credentials(notifiable_app.access_id, notifiable_app.secret_key) }
  
  get "/user_api/v1/device_tokens.json" do
    let!(:user) { create(:user, :alias => "123456789") }
    let!(:token) { create(:apns_token, :app => notifiable_app, :user_id => user.id)}
    let(:raw_post) { {:user => {:alias => user.alias}} }
    
    example "List device tokens for user", :document => :user_api do
      do_request
      expect(status).to eq 200
    end
  end
  
end