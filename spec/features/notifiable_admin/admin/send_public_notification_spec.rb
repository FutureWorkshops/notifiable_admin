require 'rails_helper'

feature 'Send public notifications' do

  let(:account) { create(:account) }  
  let(:app) { create(:app, :account => account) }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  let!(:en_token) { create(:apns_token, :app => app, :user_id => user1.id, :locale => :en) }
  let!(:ar_token) { create(:gcm_token, :app => app, :user_id => user2.id, :locale => :ar) }
 
  context "as an Account Owner" do
    let(:account_owner) { create(:account_owner, :account => account) }  
    
    before(:each) { login_as account_owner, :scope => :admin }
    
    scenario "localized" do 
      visit notifiable_admin.new_admin_account_app_notification_path(account, app)
      fill_in 'notification_localized_notifications_attributes_0_message', :with => "Hello"
      fill_in 'notification_localized_notifications_attributes_1_message', :with => "مرحبا"
      click_button 'Send'
    
      expect(page).to have_content 'Notification(s) sent successfully'
      expect(Notifiable::Notification.first.app).to eq app
      expect(Notifiable::NotificationStatus.count).to eq 2
      expect(en_token.notification_statuses.first.localized_notification.message).to eql "Hello"
      expect(ar_token.notification_statuses.first.localized_notification.message).to eql "مرحبا"
    end
    
    scenario "with params" do 
      visit notifiable_admin.new_admin_account_app_notification_path(account, app)
      fill_in 'notification_localized_notifications_attributes_0_message', :with => "Hello"
      fill_in 'notification_localized_notifications_attributes_0_params', :with => "video_id=10&image_id=20"
      click_button 'Send'
  
      expect(page).to have_content 'Notification(s) sent successfully'
      expect(Notifiable::Notification.first.app).to eq app
      expect(Notifiable::NotificationStatus.count).to eq 1
      expect(en_token.notification_statuses.first.localized_notification.message).to eql "Hello"
      expect(en_token.notification_statuses.first.localized_notification.params["video_id"]).to eql "10"
      expect(en_token.notification_statuses.first.localized_notification.params["image_id"]).to eql "20"
    end
    
    context "scheduled for the future" do
      before(:all) { Delayed::Worker.delay_jobs = true }
      after(:all) { Delayed::Worker.delay_jobs = false }
      
      let(:schedule_at) { 5.hours.from_now.strftime("%m/%d/%Y %H:%M %p") }
      
      scenario "Schedule a public notification to The Open App" do
        visit notifiable_admin.new_admin_account_app_notification_path(account, app)
        fill_in 'schedule_at', :with => schedule_at
        fill_in 'notification_localized_notifications_attributes_0_message', :with => "Hello"
        click_button 'Send'
    
        expect(page).to have_content 'Notification(s) sent successfully'
        expect(Delayed::Job.count).to eq 1
        expect(Delayed::Job.first.app_id).to eq app.id
        expect(Delayed::Job.first.notification_id).to eq Notifiable::Notification.first.id
        expect(Delayed::Job.first.run_at.strftime("%m/%d/%Y %H:%M %p")).to eq schedule_at    
      end
    end
  end
  
  context "as a Content Admin" do
    let(:content_admin) { create(:content_admin, :account => account, :apps => [app]) }
    
    before(:each) { login_as content_admin, :scope => :admin }
    
    it "to The Open App" do    
      visit notifiable_admin.new_admin_account_app_notification_path(account, app)
      fill_in 'notification_localized_notifications_attributes_0_message', :with => "Hello"
      fill_in 'notification_localized_notifications_attributes_1_message', :with => "مرحبا"
      click_button 'Send'
    
      expect(page).to have_content 'Notification(s) sent successfully'
      expect(Notifiable::Notification.first.app).to eq app
      expect(Notifiable::NotificationStatus.count).to eq 2
      expect(en_token.notification_statuses.first.localized_notification.message).to eql "Hello"
      expect(ar_token.notification_statuses.first.localized_notification.message).to eql "مرحبا"
    end    
  end
  

end