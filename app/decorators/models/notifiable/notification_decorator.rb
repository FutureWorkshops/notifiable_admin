Notifiable::Notification.class_eval do
  has_many :device_token_filters, class_name: "Notifiable::DeviceTokenFilter"
  accepts_nested_attributes_for :device_token_filters
  
  def delay_public(run_at = nil)
    delayable(run_at).send_public
  end
  
  def delay_private(user, run_at = nil)
    delayable(run_at).send_private(user)
  end
  
  def delay_filtered(run_at = nil)
    delayable(run_at).send_filtered
  end
  
  private
    def delayable(run_at)
      self.delay(:app_id => self.app.id, :notification_id => self.id, :run_at => run_at)
    end
  
    def send_filtered
      device_tokens = Notifiable::DeviceToken.where_custom_properties(app, device_token_filters)
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