class AddHstore < ActiveRecord::Migration
  
  def is_connection_postgres?
    connection.adapter_name.downcase.to_sym == :postgresql
  end
  
  def up
    if is_connection_postgres?
      enable_extension :hstore    
    else
      Rails.logger.warn("Can only enable hstore on postgres")
    end
    
  end

  def down
    disable_extension :hstore if is_connection_postgres? 
  end
end