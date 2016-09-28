require 'rails_helper'

RSpec.describe Notifiable::DeviceToken, :type => :model do
  
  describe "#custom_properties" do
    context "new value" do
      subject { create(:apns_token, :name => "MBS iPhone") }
      it { expect(subject.name).to eq "MBS iPhone" }
    end
  end
  
  describe "#where_custom_property" do
    context "equals" do
      subject! { create(:apns_token, :custom_properties => {:onsite => "1"}) }
      let(:filter) { create(:device_token_filter, property: "onsite", operator: "=", value: "1") }
            
      it { expect(Notifiable::DeviceToken.where_custom_property(filter).count).to eq 1 }
    end
  end
  
  describe ".where_custom_properties" do
    
    context "single filter" do
      let(:n_app) { create(:app) }
      subject! { create(:apns_token, app: n_app, name: "MBS iPhone", custom_properties: {onsite: "0"}) }
      let(:filter) { create(:device_token_filter, property: "onsite", operator: "=", value: "0") }
            
      it { expect(Notifiable::DeviceToken.where_custom_properties(n_app, [filter]).count).to eq 1 }
    end
        
  end
  
end