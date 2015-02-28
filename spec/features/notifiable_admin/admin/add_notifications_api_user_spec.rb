require 'rails_helper'

feature 'Add a notifications api user' do

  let(:account) { create(:account) }  
  let(:account_owner) { create(:account_owner, :account => account) }
  let!(:notifiable_app) { create(:app, :account => account) }
  
  before(:each) { login_as account_owner, :scope => :admin }
      
  scenario "Add a single notifications API user" do 
    visit notifiable_admin.new_admin_account_notifications_api_user_path(account)
    fill_in 'notifications_api_user_service_name', :with => 'CRM'
    check "notifications_api_user_app_ids_#{notifiable_app.id}"
    click_button 'Create'
    
    expect(NotifiableAdmin::NotificationsApiUser.count).to eq 1
    expect(NotifiableAdmin::NotificationsApiUser.first.service_name).to eq 'CRM'
    expect(NotifiableAdmin::NotificationsApiUser.first.apps.count).to eq 1
  end
  
  scenario "Fail to add a user without Apps" do 
    visit notifiable_admin.new_admin_account_notifications_api_user_path(account_owner.account)
    fill_in 'notifications_api_user_service_name', :with => 'CRM'
    click_button 'Create'
    
    expect(current_path).to eq notifiable_admin.new_admin_account_notifications_api_user_path(account_owner.account)
    expect(page).to have_content "Apps must include one at least one App"
  end

end