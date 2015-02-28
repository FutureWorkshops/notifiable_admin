require 'rails_helper'

feature 'Add app' do
    
  let(:super_admin){ create(:super_admin) }
  before(:each) { login_as super_admin, :scope => :admin }

  it "Create a single account" do     
    visit notifiable_admin.new_super_admin_account_path
    
    fill_in "account_name", :with => "Future Workshops" 
    click_button "Create"
    
    expect(NotifiableAdmin::Account.count).to eq 1
    expect(NotifiableAdmin::Account.first.name).to eql "Future Workshops"
  end
  
end