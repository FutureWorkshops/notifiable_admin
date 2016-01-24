require 'rails_helper'

feature 'Delete User API User' do
  
  let(:account) { create(:account) }  
  let(:account_owner) { create(:account_owner, :account => account) }
  let(:n_app) { create(:app, :account => account) }
  let!(:user_api_user) { create(:user_api_user, :app => n_app) }
    
  before(:each) { login_as account_owner, :scope => :admin }    
  
  scenario "single" do     
    visit notifiable_admin.admin_account_user_api_users_path(account)
    click_on 'Delete'
    
    expect(NotifiableAdmin::UserApiUser.count).to eq 0
    expect(page).to have_content "Key deleted"
    expect(current_path).to eql notifiable_admin.admin_account_user_api_users_path(account)
  end
  
end