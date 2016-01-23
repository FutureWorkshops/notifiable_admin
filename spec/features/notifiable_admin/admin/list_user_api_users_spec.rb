require 'rails_helper'

feature 'List user API users' do

  let(:account) { FactoryGirl.create(:account) } 
  let(:n_app) { FactoryGirl.create(:app, :account => account) }   
  let(:account_owner) { FactoryGirl.create(:account_owner, :account => account) }
  let!(:user_api_user) { FactoryGirl.create(:user_api_user, :app => n_app) }
  
  before(:each){ login_as account_owner, :scope => :admin }
  
  context "As an Account owner" do
    before(:each) { visit notifiable_admin.admin_account_user_api_users_path(account_owner.account) }
    
    it { expect(page).to have_css(".user-api-user-row", :count => 1) }
  end
end