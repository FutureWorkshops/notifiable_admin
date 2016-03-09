Notifiable::Notification.class_eval do
  
  def delay_public(run_at = nil)
    delayable(run_at).send_public
  end
  
  def delay_private(user, run_at = nil)
    delayable(run_at).send_private(user)
  end
  
  def delay_filtered(filters, run_at = nil)
    delayable(run_at).send_filtered(filters)
  end
  
  private
    def delayable(run_at)
      self.delay(:app_id => self.app.id, :notification_id => self.id, :run_at => run_at)
    end
  
    def send_filtered(filters)
      device_tokens = self.app.device_tokens
      filters.each_pair do |key,value|
        
        # MBS - delayed job fix hack. Does appear to be serializing/deserializing strings fully
        value = JSON.parse(value) if(value.kind_of?(String) && value.start_with?("[") && value.end_with?("]"))
        
        if(value.kind_of?(Array))
          value.each do |v|
            device_tokens = device_tokens.where_custom_property_like(key, v)
          end
        else
          device_tokens = device_tokens.where_custom_property(key, value)          
        end
      end
      
      send_batch(device_tokens)
    end
  
    def send_private(user)
      send_batch(user.device_tokens)
    end
  
    def send_public
      send_batch(self.app.device_tokens)
    end
    
    def send_batch(tokens)
      self.batch do
        tokens.find_each {|d| self.add_device_token(d) } 
      end 
    end
  
end