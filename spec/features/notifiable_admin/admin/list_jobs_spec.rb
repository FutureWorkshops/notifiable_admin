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

  before(:each){ notification.delay_private(@user, 5.hours.from_now) }

  context "account owner" do
    before(:each) { login_as account_owner, :scope => :admin }
    
    context "scheduled" do
      before(:each) { visit notifiable_admin.admin_account_app_jobs_path(account, notifiable_app) }
      
      it { expect(current_path).to eq notifiable_admin.admin_account_app_jobs_path(account, notifiable_app) }
      it { expect(page).to have_css(".job-row", :count=>1) }
    end
    
    context "with error" do
      before(:each) do 
        Delayed::Job.first.update_attribute(:last_error, "A very long error message that will need to be truncated because its very long winded and doesnt get to the point quickly instead it beats around the bush.")
      
        visit notifiable_admin.admin_account_app_jobs_path(account, notifiable_app) 
      end
    
      it { expect(current_path).to eq notifiable_admin.admin_account_app_jobs_path(account, notifiable_app) }    
      it { expect(page).to have_css(".job-row", :count=>1) } 
    end
       
  end
  

  
end