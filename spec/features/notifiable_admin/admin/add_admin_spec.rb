require 'rails_helper'

feature 'Add admin' do
  
  let(:account) { create(:account) }
  let!(:notifiable_app) { create(:app, :account => account) }
  
  context "as account owner" do
    let(:account_owner) { create(:account_owner, :account => account) }
    
    before(:each) { login_as account_owner, :scope => :admin }
    
    scenario "Add an account owner" do        
      visit notifiable_admin.new_admin_account_admin_path(account)
      fill_in 'admin_email', :with => 'admin2@example.com'
      fill_in 'admin_password', :with => 'london123'
      select 'Account Owner', :from => "admin_role"
      click_button 'Create'
    
      expect(NotifiableAdmin::Admin.where(:role => "account_owner").count).to eq 2
    end
    
    it "Add a content admin" do        
      visit notifiable_admin.new_admin_account_admin_path(account)
      fill_in 'admin_email', :with => 'admin2@example.com'
      fill_in 'admin_password', :with => 'london123'
      select 'Content Admin', :from => "admin_role"
      check "admin_app_ids_#{notifiable_app.id}"
      click_button 'Create'
    
      expect(NotifiableAdmin::Admin.where(:role => "content_admin").count).to eq 1
    end
    
    scenario "Fails to add a content admin with a duplicate email" do 
      create(:content_admin, :email => "matt@futureworkshops.com", :password => "london123")
    
      visit notifiable_admin.new_admin_account_admin_path(account)
      fill_in 'admin_email', :with => 'matt@futureworkshops.com'
      fill_in 'admin_password', :with => 'london123'
      check "admin_app_ids_#{notifiable_app.id}"
      click_button 'Create'
    
      expect(NotifiableAdmin::Admin.count).to eq 2
      expect(current_path).to eq notifiable_admin.new_admin_account_admin_path(account_owner.account)
      expect(page).to have_content("Email has already been taken")
    end   
     
  end
  
  
end