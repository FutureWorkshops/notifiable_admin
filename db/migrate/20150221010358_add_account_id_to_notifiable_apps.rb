class AddAccountIdToNotifiableApps < ActiveRecord::Migration
  def change
    add_column :notifiable_apps, :account_id, :integer
  end
end
