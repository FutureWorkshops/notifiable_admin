require 'rails_helper'

RSpec.describe Notifiable::App, :type => :model do
  
  it "belongs to an Account" do
    account = create(:empty_account, :name => "Future Workshops")
    create(:app, :account => account)
    
    expect(Notifiable::App.count).to eq 1
    expect(Notifiable::App.first.account.name).to eq "Future Workshops"
  end
  
  it "validates Account presence" do
    p = FactoryGirl.build(:app, :account => nil)
    
    expect{ p.save! }.to raise_error ActiveRecord::RecordInvalid
    expect(Notifiable::App.count).to eq 0  
  end
  
end
