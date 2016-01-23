require 'rails_helper'

describe NotifiableAdmin::NotificationsApi::V1::NotificationsController do

  let(:account) { create(:account) }  
  let(:n_app) { create(:app, :account => account, :name => "The Open") }
  let(:api_user) { create(:notifications_api_user, :account => account, :apps => [n_app]) }
    
  before(:each) { controller.stub(:authenticate_from_headers!){ controller.instance_variable_set(:@current_user, api_user) } }
  
  describe "#create" do

    context "localized" do
      
      before(:each) { post :create, {:app_id => n_app.id, :notification => {:localized_notifications_attributes => [{:message => "Hello", :locale => :en}]}} }

      it { expect(response.status).to eq 200 }
      it { expect(Notifiable::Notification.count).to eq 1 }
      it { expect(Notifiable::Notification.first.localized_notifications.count).to eq 1 }
    end
    
    
    context "with params" do
      before(:each) { post :create, {:app_id => n_app.id, :notification => {:localized_notifications_attributes => [{:message => "Hello", :locale => :en, :params => {:video_id => "123"}}]}} }

      it { expect(Notifiable::Notification.count).to eq 1 }
      it { expect(Notifiable::Notification.first.localized_notifications.count).to eq 1 }
      it { expect(Notifiable::Notification.first.localized_notifications.first.params['video_id']).to eq "123" }
    end
    
    context "filtered" do
      let!(:token1) { create(:apns_token, :app => n_app, :locale => :en, :onsite => "1")}
      let!(:token2) { create(:apns_token, :app => n_app, :locale => :en, :onsite => "0")}
      
      before(:each) do 
        post :create, {
          :device_token_filters => {:onsite => "1"},
          :app_id => n_app.id, 
          :notification => {
            :localized_notifications_attributes => [
              {:message => "Hello", :locale => :en}
            ]
          } 
        }        
      end

      it { expect(Notifiable::Notification.count).to eq 1 }
      it { expect(Notifiable::Notification.first.sent_count).to eq 1 }
    end
  end
end