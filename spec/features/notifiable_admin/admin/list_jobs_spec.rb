require 'rails_helper'

feature 'List jobs' do

  before(:all) { Delayed::Worker.delay_jobs = true }
  after(:all) { Delayed::Worker.delay_jobs = false }

  let(:account) { create(:account) }  
  let(:user) { create(:user_) }  
  let(:notifiable_app) { create(:app, :account => account) }
  let(:account_owner) { create(:account_owner, :account => account) }
  let(:notification) { create(:notification, :app => notifiable_app) }
  let!(:localized_notification) { create(:localized_notification, :notification => notification, :locale => :en)}

  before(:each) { notification.delay_private(@user, 5.hours.from_now) }

  context "As account owner" do
    before(:each) { login_as account_owner, :scope => :admin }
    
    it "shows a single job" do    
      visit notifiable_admin.admin_account_app_jobs_path(account, notifiable_app)

      expect(current_path).to eq notifiable_admin.admin_account_app_jobs_path(account, notifiable_app)
      expect(page).to have_css(".job-row", :count=>1)
    end    
  end

  
end