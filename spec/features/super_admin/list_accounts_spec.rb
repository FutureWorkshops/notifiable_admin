require 'rails_helper'

feature 'Lists accounts' do

  let(:super_admin){ create(:super_admin) }
  before(:each) { login_as super_admin, :scope => :admin }

  it "Lists a single account" do     
    create(:account)
    visit notifiable_admin.super_admin_accounts_path
        
    expect(page).to have_css(".account-row", :count => 1)
  end
  
end