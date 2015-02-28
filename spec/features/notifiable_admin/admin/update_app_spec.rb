require 'rails_helper'

feature 'update app' do
  
  let(:account) { create(:account) }
  let(:account_owner) { create(:account_owner, :account => account) }
  
  before(:each) do
    login_as account_owner, :scope => :admin
  end

  it "allows update of apns_certificate" do  

    visit notifiable_admin.edit_admin_account_app_path(account, account.apps.first)
    fill_in 'app_apns_certificate', :with => 'abc123'
    click_button 'Update'
    
    expect(page).to have_content("App was updated")
    expect(Notifiable::App.first.configuration[:apns][:certificate]).to eq 'abc123'

  end

end
  