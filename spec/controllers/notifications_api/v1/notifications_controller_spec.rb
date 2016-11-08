require 'rails_helper'

describe NotifiableAdmin::NotificationsApi::V1::NotificationsController do

  let(:account) { create(:account) } 
  let(:n_app) { create(:app, :account => account, :name => "The Open", :custom_device_properties => [:onsite]) }
  
  context 'authorization required' do
    let(:api_user) { create(:notifications_api_user, :account => account, :apps => [n_app], :enabled => true, :authorization_required => true) }    
    
    before(:each) do
      ApiAuth.sign!(request, api_user.access_id, api_user.secret_key)
      allow(ApiAuth).to receive(:authentic?).and_return(true)    
    end
  
    describe "#create" do

      context "localized" do
      
        before(:each) { post :create, {:app_id => n_app.id, :notification => {:localized_notifications_attributes => [{:message => "Hello", :locale => :en}]}} }

        it { expect(response.status).to eq 200 }
        it { expect(Notifiable::Notification.count).to eq 1 }
        it { expect(Notifiable::Notification.first.localized_notifications.count).to eq 1 }
        it { expect(Notifiable::Notification.first.localized_notifications.first.message).to eq "Hello" }
        it { expect(Notifiable::Notification.first.localized_notifications.first.locale).to eq "en" }
      end
    
    
      context "with params" do
        before(:each) { post :create, {:app_id => n_app.id, :notification => {:localized_notifications_attributes => [{:message => "Hello", :locale => :en, :params => {:video_id => "123"}}]}} }

        it { expect(response.status).to eq 200 }
        it { expect(Notifiable::Notification.count).to eq 1 }
        it { expect(Notifiable::Notification.first.localized_notifications.count).to eq 1 }
        it { expect(Notifiable::Notification.first.localized_notifications.first.params['video_id']).to eq "123" }
      end
    
      context "disabled" do
        before(:each) do 
          api_user.update_attribute(:enabled, false)
          post :create, {:app_id => n_app.id, :notification => {:localized_notifications_attributes => [{:message => "Hello", :locale => :en, :params => {:video_id => "123"}}]}}
        end

        it { expect(response.status).to eq 403 }
      end
    
      context "single filter" do
        let!(:token1) { create(:apns_token, :app => n_app, :locale => :en, :custom_properties => {:onsite => "1"})}
        let!(:token2) { create(:apns_token, :app => n_app, :locale => :en, :custom_properties => {:onsite => "0"})}
      
        before(:each) do 
          post :create, {
            :app_id => n_app.id, 
            :notification => {
              device_token_filters_attributes: [{property: "onsite", operator: "=", value: "1"}],
              localized_notifications_attributes: [{:message => "Hello", :locale => :en}]
            } 
          }        
        end

        it { expect(response.status).to eq 200 }
        it { expect(Notifiable::Notification.count).to eq 1 }
        it { expect(Notifiable::Notification.first.sent_count).to eq 1 }
      end

      context "for a user" do
        let!(:token1) { create(:apns_token, :app => n_app, :locale => :en, user: create(:user, alias: "matt@futureworkshops.com", app: n_app))}
        let!(:token2) { create(:apns_token, :app => n_app, :locale => :en, user: create(:user, alias: "davide@futureworkshops.com", app: n_app))}
      
        before(:each) do 
          post :create, {
            :app_id => n_app.id, 
            :notification => {
              :localized_notifications_attributes => [
                {:message => "Hello", :locale => :en}
              ]
            },
            :user => {:alias => "matt@futureworkshops.com"} 
          }        
        end

        it { expect(response.status).to eq 200 }
        it { expect(Notifiable::Notification.count).to eq 1 }
        it { expect(Notifiable::Notification.first.sent_count).to eq 1 }
      end
      
      context "include filter" do
        let!(:token1) { create(:apns_token, :app => n_app, :locale => :en, :custom_properties => {:onsite => "0,1"})}
        let!(:token2) { create(:apns_token, :app => n_app, :locale => :en, :custom_properties => {:onsite => "0"})}
      
        before(:each) do 
          post :create, {
            :app_id => n_app.id, 
            :notification => {
              device_token_filters_attributes: [{property: "onsite", operator: "LIKE", value: "1"}],
              localized_notifications_attributes: [{:message => "Hello", :locale => :en}]
            } 
          }        
        end

        it { expect(response.status).to eq 200 }
        it { expect(Notifiable::Notification.count).to eq 1 }
        it { expect(Notifiable::Notification.first.sent_count).to eq 1 }
      end
    end
  end
  
  context 'authorization not required' do  
    let(:api_user) { create(:notifications_api_user, :account => account, :apps => [n_app], :enabled => true, :authorization_required => false) }
    
    before(:each) { allow_any_instance_of(NotifiableAdmin::NotificationsApi::V1::BaseController).to receive(:unauthorized_user).and_return(api_user) }
          
    describe "#create" do                  
      before(:each) { post :create, {:app_id => n_app.id, :notification => {:localized_notifications_attributes => [{:message => "Hello", :locale => :en}]}}}

      it { expect(response.status).to eq 200 }
      it { expect(Notifiable::Notification.count).to eq 1 }
      it { expect(Notifiable::Notification.first.localized_notifications.count).to eq 1 }
    end
  end
  
end