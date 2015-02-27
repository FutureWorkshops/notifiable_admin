Notifiable::Notification.class_eval do
  
  def enqueue_send(user)
    self.batch do
      if user
        self.add_notifiable(user)
      else
        self.app.device_tokens.each {|d| self.add_device_token(d) } 
      end
    end    
  end
  
end