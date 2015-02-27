require 'rails_helper'

feature 'sign in' do

  let(:account) { create(:empty_account) }
  let(:notifiable_app) { create(:app, :account => account) }
  let(:super_admin) { create(:super_admin) }
  let(:admin) { create(:account_owner, :account => account) }
  let(:content_admin) { create(:content_admin, :account => account) }
  
  before(:each) do
    notifiable_app
    content_admin.apps << notifiable_app
    content_admin.save!
  end

  it "for super admins" do 
    visit notifiable_admin.new_admin_session_path
    fill_in 'Email', :with => super_admin.email
    fill_in 'Password', :with => super_admin.password
    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully'
  end
  
  
  it "for account owners" do 
    visit notifiable_admin.new_admin_session_path
    fill_in 'Email', :with => admin.email
    fill_in 'Password', :with => admin.password
    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully'
  end
  
  it "for content admins" do 
    visit notifiable_admin.new_admin_session_path
    fill_in 'Email', :with => content_admin.email
    fill_in 'Password', :with => content_admin.password
    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully'
  end
  
  
end