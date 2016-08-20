class AddAppToUsers < ActiveRecord::Migration
  def change
    add_column :users, :app_id, :integer, index: true, foreign_key: true
  end
end
