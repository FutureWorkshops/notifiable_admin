class CreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :alias, :null => false
    end
    
    add_index :users, :alias, :unique => true  
  end
end
