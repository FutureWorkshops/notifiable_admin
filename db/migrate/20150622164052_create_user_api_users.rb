class CreateUserApiUsers < ActiveRecord::Migration
  def change
    create_table(:user_api_users) do |t|
      
      t.string :service_name,       :null => false, :default => ""

      # API Auth
      t.string :access_id
      t.string :secret_key
      
      t.references :app

      t.timestamps
    end

    add_index :user_api_users, :access_id, :unique => true
    add_index :user_api_users, :secret_key, :unique => true
    
  end
end
