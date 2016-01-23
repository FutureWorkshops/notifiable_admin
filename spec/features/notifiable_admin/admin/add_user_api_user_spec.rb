require 'rails_helper'

feature 'Add a user api user' do

  let(:account) { create(:account) }  
  let(:account_owner) { create(:account_owner, :account => account) }
  let!(:n_app) { create(:app, :account => account, :name => "The Open") }
        
  context "as Account owner" do
    before(:each) do
      login_as account_owner, :scope => :admin
      visit notifiable_admin.new_admin_account_user_api_user_path(account)
      fill_in 'user_api_user_service_name', :with => 'iPhone App 1.0.0'
      select 'The Open', :from => :user_api_user_app_id
      click_button 'Create'      
    end

    
    it { expect(NotifiableAdmin::UserApiUser.count).to eq 1 }
    it { expect(NotifiableAdmin::UserApiUser.first.service_name).to eq "iPhone App 1.0.0" }
    it { expect(NotifiableAdmin::UserApiUser.first.app).to eq n_app }
  end

end