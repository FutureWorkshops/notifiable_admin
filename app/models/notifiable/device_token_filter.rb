module Notifiable
  class DeviceTokenFilter < ActiveRecord::Base
    belongs_to :notification, class_name: "Notifiable::Notification"
  
    def postgres_where_clause
      value = "%#{value}%" if operator == "LIKE"
    
      "'#{property}' #{operator} '#{value}'"
    end
  end
end