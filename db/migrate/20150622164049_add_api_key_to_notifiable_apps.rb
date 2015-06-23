class AddApiKeyToNotifiableApps < ActiveRecord::Migration
  def change
    add_column :notifiable_apps, :access_id, :string
    add_column :notifiable_apps, :secret_key, :string
  end
end
