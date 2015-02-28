class CreateAdminsNotifiableApps < ActiveRecord::Migration
  def change
    create_table :admins_notifiable_apps do |t|
      t.references :admin
      t.references :app
    end
  end
end
