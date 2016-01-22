require 'rails_helper'

RSpec.describe Notifiable::DeviceToken, :type => :model do
  
  describe "#custom_properties" do
    
    context "new value" do
      subject { create(:apns_token, :name => "MBS iPhone") }
            
      it { expect(subject.name).to eq "MBS iPhone" }
    end
    
    context "filter" do
      subject! { create(:apns_token, :onsite => "1") }
            
      it { expect(Notifiable::DeviceToken.where_custom_property('onsite', '1').count).to eq 1 }
    end
    
  end
  
end