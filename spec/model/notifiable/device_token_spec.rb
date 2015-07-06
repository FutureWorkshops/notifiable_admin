require 'rails_helper'

RSpec.describe Notifiable::DeviceToken, :type => :model do
  
  describe "#properties" do
    
    context "new value" do
      subject { create(:apns_token, :device_name => "Matt's iPhone") }
      
      before(:each) { subject.settings['onsite'] = true; subject.save }
      
      it { expect(subject.settings['onsite']).to eq true }
    end
    
    context "filter value" do
      subject { create(:apns_token) }
      
      before(:each) { subject.settings['onsite'] = "true"; subject.save }
      
      it { byebug; expect(Notifiable::DeviceToken.where("settings -> 'onsite' = 'true'").count).to eq 1 }
    end
    
  end
  
end