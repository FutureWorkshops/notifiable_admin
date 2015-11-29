class Notifiable::App
  
  def configuration
    unless read_attribute(:configuration)
      write_attribute(:configuration, {:apns => {:passphrase => nil, :certificate => nil}, :gcm => {:api_key => nil}})
      self.apns_sandbox = "1"
    end
    read_attribute(:configuration)
  end

  def apns_passphrase=(apns_passphrase)
    self.configuration[:apns][:passphrase] = apns_passphrase
  end
  
  def apns_passphrase
    self.configuration[:apns][:passphrase]
  end
  
  def apns_certificate=(apns_certificate)
    self.configuration[:apns][:certificate] = apns_certificate
  end
  
  def apns_certificate
    self.configuration[:apns][:certificate]
  end

  def apns_sandbox
    self.configuration[:apns][:gateway_host].eql? ENV["apns_gateway_host"]
  end
  
  def apns_sandbox=(apns_sandbox)
    if apns_sandbox.eql? "1"
      self.configuration[:apns][:gateway_host] = ENV["apns_sandbox_gateway_host"]
      self.configuration[:apns][:gateway_port] = ENV["apns_sandbox_gateway_port"]
      self.configuration[:apns][:feedback_host] = ENV["apns_sandbox_feedback_host"]
      self.configuration[:apns][:feedback_port] = ENV["apns_sandbox_feedback_port"]
    else
      self.configuration[:apns][:gateway_host] = ENV["apns_gateway_host"]
      self.configuration[:apns][:gateway_port] = ENV["apns_gateway_port"]
      self.configuration[:apns][:feedback_host] = ENV["apns_feedback_host"]
      self.configuration[:apns][:feedback_port] = ENV["apns_feedback_port"]
    end
  end
  
  def gcm_api_key=(gcm_api_key)
    self.configuration[:gcm][:api_key] = gcm_api_key
  end
  
  def gcm_api_key
    self.configuration[:gcm][:api_key]
  end
end