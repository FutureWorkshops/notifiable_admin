require 'rails_helper'

RSpec.describe Notifiable::App, :type => :model do
  let(:account) { create(:empty_account, :name => "Future Workshops") }
  
  it "belongs to an Account" do
    create(:app, :account => account)
    
    expect(Notifiable::App.count).to eq 1
    expect(Notifiable::App.first.account.name).to eq "Future Workshops"
  end
  
  it "validates Account presence" do
    p = FactoryGirl.build(:app, :account => nil)
    
    expect{ p.save! }.to raise_error ActiveRecord::RecordInvalid
    expect(Notifiable::App.count).to eq 0  
  end
  
  describe "#custom_device_properties" do
    
    context "default" do
      subject { create(:app, :account => account) }

      it { expect(subject.custom_device_properties).to eq [] }            
      it { expect(subject.custom_device_properties_s).to eq "" }
    end
    
    context "multiple" do
      subject { create(:app, :account => account) }
      
      before(:each) { subject.custom_device_properties = [:onsite, :tag] } 

      it { expect(subject.custom_device_properties).to eq [:onsite, :tag] }            
      it { expect(subject.custom_device_properties_s).to eq "onsite,tag" }
    end
    
    context "set multiple with space" do
      subject { create(:app, :account => account) }
      
      before(:each) { subject.custom_device_properties_s = "onsite, tag" } 

      it { expect(subject.custom_device_properties).to eq [:onsite, :tag] }            
      it { expect(subject.custom_device_properties_s).to eq "onsite,tag" }
    end
    
  end
  
end
