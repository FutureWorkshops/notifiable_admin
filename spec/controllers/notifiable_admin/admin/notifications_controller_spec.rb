require 'rails_helper'

describe NotifiableAdmin::Admin::NotificationsController do

  let(:account) { create(:account) }  
  let(:the_open_app) { create(:app, :account => account, :name => "The Open", :custom_device_properties => [:onsite]) }
  let(:the_rules_app) { create(:app, :account => account, :name => "The Rules of Golf") }
  
  describe "#new" do
    
    context "account owner" do
      let(:account_owner) { create(:account_owner, :account => account) }  
    
      before(:each) { admin_sign_in account_owner }
    
      describe "two locales" do
        before(:each) do
          Notifiable.locales = [:en, :ar]   
          get :new, {:account_id => account.id, :app_id => the_open_app.id}
        end
      
        it { expect(assigns(:user_id)).to be_nil }
        it { expect(assigns(:notification).localized_notifications[0].locale).to eq 'en' }
        it { expect(assigns(:notification).localized_notifications[1].locale).to eq 'ar' }
      end
    end
    
  end
  
  describe "#create" do
    
    context "account owner" do
      let(:account_owner) { create(:account_owner, :account => account) }  
    
      before(:each) { admin_sign_in account_owner }
    
      describe "single public notification" do
        let(:user1) { create(:user) }
        let(:user2) { create(:user) }
      
        let!(:token1) { create(:apns_token, :app => the_open_app, :user_id => user1.id)}
        let!(:token2) { create(:apns_token, :app => the_rules_app, :user_id => user2.id)}
      
        before(:each) do          
          post :create, {:account_id => account.id, :app_id => the_open_app.id, :notification => {:localized_notifications_attributes => {"0" => {:message => "Hello", :locale => :en}}}}
        end
      
        it { expect(Notifiable::Notification.count).to eq 1 }
        it { expect(Notifiable::Notification.first.app).to eq the_open_app }
        it { expect(Notifiable::NotificationStatus.count).to eq 1 }
        it { expect(Notifiable::NotificationStatus.first.device_token).to eq token1 }
        it { expect(Notifiable::NotificationStatus.first.localized_notification).to eq Notifiable::LocalizedNotification.first }
      end
      
      describe "localized notification" do
        let(:user1) { create(:user) }
        let(:user2) { create(:user) }
      
        let!(:en_token) { create(:apns_token, :app => the_open_app, :user_id => user1.id, :locale => :en)}
        let!(:ar_token) { create(:apns_token, :app => the_open_app, :user_id => user2.id, :locale => :ar)}
      
        before(:each) do          
          post :create, {:account_id => account.id, :app_id => the_open_app.id, :notification => {:localized_notifications_attributes => {"0" => {:locale => :en, :message => "Hello"}, "1" => {:locale => :ar, :message => "مرحبا"}}}}
        end
      
        it { expect(Notifiable::Notification.count).to eq 1 }
        it { expect(Notifiable::Notification.first.app).to eq the_open_app }
        it { expect(Notifiable::Notification.first.localized_notifications.count).to eq 2 }
        it { expect(Notifiable::NotificationStatus.count).to eq 2 }
        
        it { expect(en_token.notification_statuses.count).to eq 1 }
        it { expect(en_token.notification_statuses.first.localized_notification.message).to eq "Hello" }
        it { expect(en_token.notification_statuses.first.localized_notification.locale).to eq "en" }
        
        it { expect(ar_token.notification_statuses.first.localized_notification.message).to eq "مرحبا" }
        it { expect(ar_token.notification_statuses.first.localized_notification.locale).to eq "ar" }
      end
      
      describe "scheduled notification" do
        let(:user1) { create(:user) }      
        let!(:en_token) { create(:apns_token, :app => the_open_app, :user_id => user1.id, :locale => :en)}
        let(:schedule_at) { 5.hours.from_now.strftime("%m/%d/%Y %H:%M %p") }
      
        before(:all) { Delayed::Worker.delay_jobs = true }
        after(:all) { Delayed::Worker.delay_jobs = false }
        
        before(:each) do          
          post :create, {:schedule_at => schedule_at, :account_id => account.id, :app_id => the_open_app.id, :notification => {:localized_notifications_attributes => {"0" => {:locale => :en, :message => "Hello"}}}}
        end
      
        it { expect(Delayed::Job.count).to eq 1 }
        it { expect(Delayed::Job.first.run_at.strftime("%m/%d/%Y %H:%M %p")).to eq schedule_at }
        
      end
      
      describe "single filter" do
        let(:user1) { create(:user) }
        let(:user2) { create(:user) }
      
        let!(:token1) { create(:apns_token, :app => the_open_app, :user_id => user1.id, :custom_properties => {:onsite => "0"})}
        let!(:token2) { create(:apns_token, :app => the_open_app, :user_id => user2.id, :custom_properties => {:onsite => "1"})}
      
        before(:each) do          
          post :create, {:account_id => account.id, :app_id => the_open_app.id, :notification => {:localized_notifications_attributes => {"0" => {:message => "Hello", :locale => :en}}, device_token_filters_attributes: [{property: "onsite", operator: "=", value: "0"}]}}
        end
      
        it { expect(Notifiable::Notification.count).to eq 1 }
        it { expect(Notifiable::Notification.first.app).to eq the_open_app }
        it { expect(Notifiable::NotificationStatus.count).to eq 1 }
        it { expect(Notifiable::NotificationStatus.first.device_token).to eq token1 }
        it { expect(Notifiable::NotificationStatus.first.localized_notification).to eq Notifiable::LocalizedNotification.first }
      end
      
      describe "no filter" do
        let(:user1) { create(:user) }
        let(:user2) { create(:user) }
      
        let!(:token1) { create(:apns_token, :app => the_open_app, :user_id => user1.id, :custom_properties => {:onsite => "0"})}
        let!(:token2) { create(:apns_token, :app => the_open_app, :user_id => user2.id, :custom_properties => {:onsite => "1"})}
      
        before(:each) do          
          post :create, {:account_id => account.id, :app_id => the_open_app.id, :notification => {:localized_notifications_attributes => {"0" => {:message => "Hello", :locale => :en}}}}
        end
      
        it { expect(Notifiable::NotificationStatus.count).to eq 2 }
      end
      
      describe "contains filter" do
        let(:user1) { create(:user) }
        let(:user2) { create(:user) }
      
        let!(:token1) { create(:apns_token, :app => the_open_app, :user_id => user1.id, :custom_properties => {:onsite => ["0", "1"]})}
        let!(:token2) { create(:apns_token, :app => the_open_app, :user_id => user2.id, :custom_properties => {:onsite => ["2"]})}
      
        before(:each) do          
          post :create, {:account_id => account.id, :app_id => the_open_app.id, :notification => {:localized_notifications_attributes => {"0" => {:message => "Hello", :locale => :en}}, device_token_filters_attributes: [{property: "onsite", operator: "LIKE", value: "0"}]}}
        end
      
        it { expect(Notifiable::NotificationStatus.count).to eq 1 }
      end
      
    end
        
  end 
   
   

  

end