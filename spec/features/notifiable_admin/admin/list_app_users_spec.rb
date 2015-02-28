require 'rails_helper'

feature 'List App Users' do

  let(:account) { create(:account) }  
  let(:notifiable_app) { create(:app, :account => account) }
  let(:account_owner) { create(:account_owner, :account => account) }
  let(:user) { create(:user, :alias => "matt@futureworkshops.com") }
  let!(:token) { create(:apns_token, :app => notifiable_app, :user_id => user.id) }
  
  before(:each) { login_as account_owner, :scope => :admin }
    
  it "for a single user" do    
    visit notifiable_admin.admin_account_app_users_path(account, notifiable_app)

    expect(current_path).to eql notifiable_admin.admin_account_app_users_path(notifiable_app.account, notifiable_app)
    expect(page).to have_css(".user-row", :count=>1)
    expect(page).to have_content(user.alias)    
  end
  
end