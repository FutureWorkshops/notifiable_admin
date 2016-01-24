class CreateNotificationsApiUsers < ActiveRecord::Migration
  def change
    create_table(:notifications_api_users) do |t|
      
      t.string :service_name,       :null => false, :default => ""
      
      # API Auth
      t.string :access_id
      t.string :secret_key
      
      t.boolean :enabled, :default => true
      
      t.references :account

      t.timestamps
    end

    add_index :notifications_api_users, :access_id, :unique => true
    add_index :notifications_api_users, :secret_key, :unique => true
    
  end
end
