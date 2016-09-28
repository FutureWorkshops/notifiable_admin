class CreateDeviceTokenFilters < ActiveRecord::Migration
  def change
    create_table(:notifiable_device_token_filters) do |t|
      t.string :property, :null => false
      t.string :operator, :null => false
      t.string :value, :null => false
      t.belongs_to :notification
    end 
  end
end
