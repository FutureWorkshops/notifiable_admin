require 'rails_helper'

feature 'Delete User API User' do
  
  let(:account) { create(:account) }  
  let(:account_owner) { create(:account_owner, :account => account) }
  let(:the_open_app) { create(:app, :account => account, name: "The Open") }
  let!(:d1) { create(:device_token, app: the_open_app)}
    
  before(:each) { login_as account_owner, :scope => :admin }    
  
  scenario do     
    visit notifiable_admin.edit_admin_account_app_path(account, the_open_app)
    click_on 'Delete Devices'
    
    expect(the_open_app.device_tokens.count).to eq 0
    expect(page).to have_content "All The Open devices have been deleted."
    expect(current_path).to eql notifiable_admin.edit_admin_account_app_path(account, the_open_app)
  end
  
end