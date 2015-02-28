require 'rails_helper'

feature 'list notifications API users' do

  let(:account) { FactoryGirl.create(:account) }  
  let(:account_owner) { FactoryGirl.create(:account_owner, :account => account) }
  
  before(:each) do    
    login_as account_owner, :scope => :admin
  end
  
  it "as an Account Owner" do     
    FactoryGirl.create(:notifications_api_user, :account => account)
    
    visit notifiable_admin.admin_account_notifications_api_users_path(account_owner.account)

    page.should have_css("table.table tr", :count=>2)
  end
end