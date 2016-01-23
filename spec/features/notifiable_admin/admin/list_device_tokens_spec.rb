require 'rails_helper'

feature 'list device tokens' do

  let(:account) { create(:account) }  
  let(:notifiable_app) { create(:app, :account => account) }
  let(:account_owner) { create(:account_owner, :account => account) }
  let!(:apns_token) { create(:apns_token, :app => notifiable_app, :name => "MBS iPhone") }
  
  before(:each) { login_as account_owner, :scope => :admin }
    
  it "when anonymous" do    
    visit notifiable_admin.admin_account_app_device_tokens_path(notifiable_app.account, notifiable_app)

    expect(current_path).to eql notifiable_admin.admin_account_app_device_tokens_path(notifiable_app.account, notifiable_app)
    expect(page).to have_css("table.table tr", :count=>2)
    expect(page).to have_content(apns_token.name)    
  end
  
end