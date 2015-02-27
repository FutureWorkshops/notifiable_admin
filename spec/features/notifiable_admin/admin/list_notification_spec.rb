require 'rails_helper'

feature 'List notifications' do

  let(:account) { create(:account) }
  let(:notifiable_app) { create(:app, :account => account) }
  let(:content_admin) { create(:content_admin, :apps => [notifiable_app], :account => account) }
  let(:notification) { create(:notification, :app => notifiable_app) }
  let!(:localized_notification) { create(:localized_notification, :notification => notification) }
  
  before(:each) do
    login_as content_admin, :scope => :admin
  end
  
  scenario "in an App" do     
    visit notifiable_admin.admin_account_app_notifications_path(content_admin.account, notifiable_app)
    
    expect(current_path).to eq notifiable_admin.admin_account_app_notifications_path(content_admin.account, notifiable_app)
    expect(page).to have_css(".notification-row", :count => 1)
  end  
end