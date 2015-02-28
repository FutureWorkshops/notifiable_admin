require 'rails_helper'

feature 'list notification statuses' do

  let(:account) { create(:account) }
  let(:notifiable_app) { create(:app, :account => account) }
  let(:content_admin) { create(:content_admin, :apps => [notifiable_app]) }
  let(:notification) { create(:notification, :app => notifiable_app) }
  let(:localized_notification) { create(:localized_notification, :notification => notification, :locale => :en) }
  let(:user) { create(:user) }  
  let(:device_token) { create(:apns_token, :app => notifiable_app, :locale => :en)}
  
  let!(:status) { create(:notification_status, :localized_notification => localized_notification, :device_token => device_token) }
  
  before(:each) do
    login_as content_admin, :scope => :admin
  end
  
  it "as a content admin" do 
    visit notifiable_admin.admin_account_app_notification_notification_statuses_path(content_admin.account, notification.app, notification)

    expect(current_path).to eq notifiable_admin.admin_account_app_notification_notification_statuses_path(content_admin.account, notification.app, notification)
    expect(page).to have_css(".notification-status-row", :count => 1)
  end
  
end