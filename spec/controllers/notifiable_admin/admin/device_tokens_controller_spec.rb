require 'rails_helper'

describe NotifiableAdmin::Admin::DeviceTokensController do

  let(:account) { create(:account) }  
  let(:account_owner) { create(:account_owner, :account => account) }
  let(:the_open_app) { create(:app, :account => account, :name => "The Open", :custom_device_properties => [:onsite]) }
  let(:the_rules_app) { create(:app, :account => account, :name => "The Rules of Golf") }
  
  describe "#destroy_all" do
    let!(:d1) { create(:device_token, app: the_open_app) }
    
    context "account owner" do
      
      before(:each) do 
        admin_sign_in account_owner
        delete :destroy_all, {:account_id => account.id, :app_id => the_open_app.id}
      end

      it { expect(the_open_app.device_tokens.count).to eq 0 }
      it { expect(subject).to redirect_to(notifiable_admin.edit_admin_account_app_path(account, the_open_app)) }
    end
    
  end

end