require 'rails_helper'

feature 'Delete job' do

  before(:all) { Delayed::Worker.delay_jobs = true }
  after(:all) { Delayed::Worker.delay_jobs = false }

  let(:account) { create(:account) }  
  let(:notifiable_app) { create(:app, :account => account) }
  let(:account_owner) { create(:account_owner, :account => account) }
  let(:notification) { create(:notification, :app => notifiable_app) }
  let!(:localized_notification) { create(:localized_notification, :notification => notification, :locale => :en)}

  before(:each) { notification.delay_public(5.hours.from_now) }

  context "As account owner" do
    before(:each) { login_as account_owner, :scope => :admin }
    
    it "Delete a single job" do    
      visit notifiable_admin.admin_account_app_jobs_path(account, notifiable_app)
      click_link "Delete"

      expect(current_path).to eq notifiable_admin.admin_account_app_jobs_path(account, notifiable_app)
      expect(Delayed::Job.count).to eq 0
      expect(Notifiable::Notification.count).to eq 0
    end    
  end

  
end