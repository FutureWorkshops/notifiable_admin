require 'rails_helper'

feature 'show user details' do
  
  let(:notifiable_app) { FactoryGirl.create(:app) }
  let(:user) { FactoryGirl.create(:user) { |user| FactoryGirl.create(:apns_token, :app_id => notifiable_app.id, :user_id => user.id) }}
  let(:content_admin) { FactoryGirl.create(:content_admin, :apps => [notifiable_app]) }
  
  before(:each) do
    login_as content_admin, :scope => :admin
  end
  
  it "for a single user" do
    visit notifiable_admin.admin_account_app_user_path(content_admin.account, notifiable_app, user)

    expect(page).to have_css(".device_token-row", :count=>1)
  end
  
end