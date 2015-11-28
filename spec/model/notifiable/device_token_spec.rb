require 'rails_helper'

RSpec.describe Notifiable::DeviceToken, :type => :model do
  
  describe "#custom_properties" do
    
    context "new value" do
      subject { create(:apns_token, :device_name => "MBS iPhone") }
            
      it { expect(subject.device_name).to eq "MBS iPhone" }
    end
    
    context "filter" do
      subject! { create(:apns_token, :device_name => "MBS iPhone") }
            
      it { expect(Notifiable::DeviceToken.where("custom_properties -> 'device_name' = 'MBS iPhone'").count).to eq 1 }
    end
    
  end
  
end