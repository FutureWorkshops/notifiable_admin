require 'rails_helper'

feature 'Send private notifications' do
  
  let(:account) { create(:account) }  
  let(:app) { create(:app, :account => account) }
  let(:user1) { create(:user, app: app) }
  let!(:en_token) { create(:apns_token, :app => app, :user_id => user1.id, :locale => :en) }
  
  let(:content_admin) { FactoryGirl.create(:content_admin, :apps => [app]) }
  
  before(:each) do
    login_as content_admin, :scope => :admin
  end
  
  context "as a Content Admin" do
    it "to a single User" do 
      visit "#{notifiable_admin.new_admin_account_app_notification_path(content_admin.account, app)}?notification[user_id]=#{user1.id}"
    
      fill_in 'notification_localized_notifications_attributes_0_message', :with => "Hello"
    
      click_button 'Send'
    
      expect(page).to have_content 'Notification(s) sent successfully'
      expect(Notifiable::NotificationStatus.count).to eq 1
      expect(Notifiable::NotificationStatus.all[0].localized_notification.message).to eq "Hello"
      expect(Notifiable::NotificationStatus.all[0].device_token).to eq user1.device_tokens[0]
    end
  end
    
end