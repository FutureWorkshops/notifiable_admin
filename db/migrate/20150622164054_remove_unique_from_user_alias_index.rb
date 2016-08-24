class RemoveUniqueFromUserAliasIndex < ActiveRecord::Migration
  def change
    remove_index :users, :alias
    add_index :users, :alias
  end
end
