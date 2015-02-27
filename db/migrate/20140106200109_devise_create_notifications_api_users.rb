class DeviseCreateNotificationsApiUsers < ActiveRecord::Migration
  def change
    create_table(:notifications_api_users) do |t|
      
      t.string :service_name,       :null => false, :default => ""

      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      
      ## Lockable
      t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      t.datetime :locked_at
      
      # API Auth
      t.string :access_id
      t.string :secret_key
      
      t.references :account

      t.timestamps
    end

    add_index :notifications_api_users, :access_id, :unique => true
    add_index :notifications_api_users, :secret_key, :unique => true
    
  end
end
