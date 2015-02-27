require 'rails_helper'

describe 'notifiable_admin/admin/admins/new.html.erb', :type => :view do
  
  let(:account1) { create(:account) }
  let(:account2) { create(:account) }
  let(:account1_owner) { create(:account_owner, :account => account1) }

  let!(:account1_app) { create(:app, :account => account1, :name => "test *** ") }
  let!(:account2_app) { create(:app, :account => account2) }

  
  it 'displays correct Apps' do
    assign(:account, account1)
    assign(:apps, [account1_app])
    assign(:admin, NotifiableAdmin::Admin.new)

    render

    expect(rendered).to have_css("#admin_app_ids_#{account1_app.id}")
    expect(rendered).to_not have_css("#admin_app_ids_#{account2_app.id}")
  end
end