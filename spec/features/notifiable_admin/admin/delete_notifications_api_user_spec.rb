require 'rails_helper'

feature 'Delete Notifications API User' do
  
  let(:account) { create(:account) }  
  let(:account_owner) { create(:account_owner, :account => account) }

  let!(:notifications_api_user) { create(:notifications_api_user, :account => account) }
    
  before(:each) { login_as account_owner, :scope => :admin }    
  
  it "Delete a single Notifications API user" do     
    visit notifiable_admin.admin_account_notifications_api_users_path(account)
    click_on 'Delete'
    
    expect(NotifiableAdmin::NotificationsApiUser.count).to eq 0
    expect(page).to have_content "Notifications API Key deleted"
    expect(current_path).to eql notifiable_admin.admin_account_notifications_api_users_path(account)
  end
  
end