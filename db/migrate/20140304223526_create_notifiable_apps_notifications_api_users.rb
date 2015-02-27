class CreateNotifiableAppsNotificationsApiUsers < ActiveRecord::Migration
  def change
    create_table :notifiable_apps_notifications_api_users do |t|
      t.references :app
      t.references :notifications_api_user
    end
  end
end
