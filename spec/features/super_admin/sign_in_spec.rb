require 'rails_helper'

feature 'sign in' do

  subject(:super_admin) { create(:super_admin) }

  it "redirects to accounts page" do 
    visit notifiable_admin.new_admin_session_path
    fill_in 'Email', :with => super_admin.email
    fill_in 'Password', :with => super_admin.password
    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully'
    expect(current_path).to eql notifiable_admin.super_admin_accounts_path
  end
  
end