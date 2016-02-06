require 'rails_helper'

feature 'Disable Authorization Notifications API User' do
  
  let(:account) { create(:account) }  
  let(:account_owner) { create(:account_owner, :account => account) }
  let!(:notifications_api_user) { create(:notifications_api_user, :account => account, :authorization_required => true) }
    
  before(:each) { login_as account_owner, :scope => :admin }    
  
  scenario do     
    visit notifiable_admin.admin_account_notifications_api_users_path(account)
    click_on 'Disable Auth'
    
    expect(page).to have_content "Authorization disabled"
    expect(current_path).to eql notifiable_admin.admin_account_notifications_api_users_path(account)
    expect(NotifiableAdmin::NotificationsApiUser.count).to eq 1
    expect(NotifiableAdmin::NotificationsApiUser.first.authorization_required?).to eq false
  end
  
end