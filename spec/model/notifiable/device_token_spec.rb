require 'rails_helper'

RSpec.describe Notifiable::DeviceToken, :type => :model do
  
  describe "#settings" do
    
    context "new value" do
      subject { create(:apns_token, :onsite => true) }
            
      it { expect(subject.settings['onsite']).to eq true }
    end
    
    context "filter" do
      subject! { create(:apns_token, :onsite => true) }
            
      it { expect(Notifiable::DeviceToken.where("settings -> 'onsite' = 'true'").count).to eq 1 }
    end
    
  end
  
end