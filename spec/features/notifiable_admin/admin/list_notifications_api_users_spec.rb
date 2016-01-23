require 'rails_helper'

feature 'list notifications API users' do

  let(:account) { FactoryGirl.create(:account) }  
  let(:account_owner) { FactoryGirl.create(:account_owner, :account => account) }
  let!(:notifications_api_user) { FactoryGirl.create(:notifications_api_user, :account => account) }
  
  before(:each) { login_as account_owner, :scope => :admin }
  
  context "As an Account owner" do
    before(:each) { visit notifiable_admin.admin_account_notifications_api_users_path(account_owner.account) }

    it { expect(page).to have_css(".notifications-api-user-row", :count => 1) }
  end
end