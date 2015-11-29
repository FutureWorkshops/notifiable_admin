require 'rails_helper'

describe NotifiableAdmin::UserApi::V1::DeviceTokensController do

  let(:account) { create(:account) }  
  let(:n_app) { create(:app, :account => account, :name => "The Open") }
  
  before(:each) { controller.stub(:authenticate_from_headers!){ controller.instance_variable_set(:@app, n_app) } }
  
  describe "#create" do

    context "new user" do
      before(:each) { post :create, {:provider => 'apns', :token => 'ABC12345678910', :locale => "en", :user => {:alias => "matt@futureworkshops.com"}} }

      it { expect(NotifiableAdmin::User.count).to eq 1 }
      it { expect(NotifiableAdmin::User.first.device_tokens.count).to eq 1 }
      
      it { expect(Notifiable::DeviceToken.count).to eq 1 }
      it { expect(Notifiable::DeviceToken.first.provider).to eq "apns" }
      it { expect(Notifiable::DeviceToken.first.token).to eq "ABC12345678910" }      
      it { expect(Notifiable::DeviceToken.first.locale).to eq "en" }    
      it { expect(Notifiable::DeviceToken.first.is_valid).to eq true } 
      it { expect(json['id']).to eq Notifiable::DeviceToken.first.id }    
    end
    
    context "existing user" do
      let!(:user) { create(:user, :alias => "matt@futureworkshops.com") }
      
      before(:each) { post :create, {:provider => 'apns', :token => 'ABC12345678910', :locale => "en", :user => {:alias => "matt@futureworkshops.com"}} }

      it { expect(NotifiableAdmin::User.count).to eq 1 }
      it { expect(NotifiableAdmin::User.first.device_tokens.count).to eq 1 }
      
      it { expect(Notifiable::DeviceToken.count).to eq 1 }
      it { expect(Notifiable::DeviceToken.first.provider).to eq "apns" }
      it { expect(Notifiable::DeviceToken.first.token).to eq "ABC12345678910" }      
      it { expect(Notifiable::DeviceToken.first.locale).to eq "en" }    
      it { expect(Notifiable::DeviceToken.first.is_valid).to eq true } 
      it { expect(json['id']).to eq Notifiable::DeviceToken.first.id }    
    end
    
    context "new token without user" do
      before(:each) { post :create, {:provider => 'apns', :token => 'ABC12345678910', :locale => "en"} }
      
      it { expect(Notifiable::DeviceToken.count).to eq 1 }
      it { expect(Notifiable::DeviceToken.first.provider).to eq "apns" }
      it { expect(Notifiable::DeviceToken.first.token).to eq "ABC12345678910" }      
      it { expect(Notifiable::DeviceToken.first.locale).to eq "en" }    
      it { expect(Notifiable::DeviceToken.first.is_valid).to eq true } 
      it { expect(json['id']).to eq Notifiable::DeviceToken.first.id }    
    end
    
    context "new token with custom properties" do
      before(:each) { post :create, {:provider => 'apns', :token => 'ABC12345678910', :locale => "en", :device_token_properties => {:device_name => "MBS iPhone"}} }
      
      it { expect(Notifiable::DeviceToken.count).to eq 1 }
      it { expect(Notifiable::DeviceToken.first.provider).to eq "apns" }
      it { expect(Notifiable::DeviceToken.first.token).to eq "ABC12345678910" }      
      it { expect(Notifiable::DeviceToken.first.locale).to eq "en" }    
      it { expect(Notifiable::DeviceToken.first.is_valid).to eq true } 
      it { expect(Notifiable::DeviceToken.first.device_name).to eq "MBS iPhone" } 
      it { expect(json['id']).to eq Notifiable::DeviceToken.first.id }    
    end
  end
  
  describe "#update" do
    
    context "change token" do
      let(:device_token) { create(:apns_token, :token => "ABC12345678910", :app_id => n_app.id ) }
      
      before(:each) { put :update, {:id => device_token.id, :token => 'DEF987654321' } }
      
      it { expect(Notifiable::DeviceToken.count).to eq 1 }
      it { expect(Notifiable::DeviceToken.first.token).to eq "DEF987654321" }      
    end
    
    context "change locale" do
      let(:device_token) { create(:apns_token, :locale => "en", :app_id => n_app.id ) }
      
      before(:each) { put :update, {:id => device_token.id, :locale => 'de' } }
      
      it { expect(Notifiable::DeviceToken.count).to eq 1 }
      it { expect(Notifiable::DeviceToken.first.locale).to eq "de" }      
    end
    
    context "token does not exist" do      
      before(:each) { put :update, {:id => -1, :token => 'DEF987654321' } }
      
      it { expect(response.status).to eq(404) }
    end
    
  end
  
  describe "index" do
    let!(:user) { create(:user, :alias => "123456789") }
        
    context "Single device token" do
      let!(:device_token) { create(:apns_token, :user_id => user.id, :app => n_app) }

      it "recognises correct parameters" do
        get :index, { :user => {:alias => "123456789"}, :format => :json }
        expect(response).to have_http_status(:ok)
        expect(assigns(:device_tokens).count).to eq 1
      end
      
      it "returns 200 if the user is not found" do
        get :index, { :user => {:alias => "987654321"}, :format => :json }
        expect(response).to have_http_status(:ok)
        expect(assigns(:device_tokens).count).to eq 0
      end
    end
  end
  
end