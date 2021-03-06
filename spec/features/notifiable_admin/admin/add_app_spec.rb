require 'rails_helper'

feature 'add app' do

  let(:account_owner) { create(:account_owner) }
  
  it "as account owner" do  
    login_as account_owner, :scope => :admin
    visit notifiable_admin.new_admin_account_app_path(account_owner.account) 
    fill_in 'app_apns_certificate', :with => 'abc123'
    click_button 'Save'
    
    expect(page).to have_content("App was created")
    expect(Notifiable::App.count).to eq 2
    expect(Notifiable::App.last.configuration[:apns][:certificate]).to eql 'abc123'
  end
end