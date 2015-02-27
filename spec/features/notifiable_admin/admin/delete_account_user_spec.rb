require 'rails_helper'

feature 'delete account user' do

  let(:account) { create(:account) }  
  let(:notifiable_app) { create(:app, :account => account) }
  let(:account_owner) { create(:account_owner, :account => account) }
  
  let!(:content_admin) { create(:content_admin, :account => account, :apps => [notifiable_app]) }
  
  before(:each) { login_as account_owner, :scope => :admin }

  it "Delete a single content admin" do 
    visit notifiable_admin.admin_account_admins_path(account)
    click_on 'Delete'
    
    expect(NotifiableAdmin::Admin.count).to eq 1
    expect(page).to have_content "Account user deleted"
    expect(current_path).to eq notifiable_admin.admin_account_admins_path(account_owner.account)
  end
  
end