class Notifiable::App
  
  def configuration
    unless read_attribute(:configuration)
      write_attribute(:configuration, {:apns => {:passphrase => nil, :certificate => nil, :sandbox => "1"}})
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
    self.configuration[:apns][:sandbox].eql? "1"
  end
  
  def apns_sandbox=(apns_sandbox)
    self.configuration[:apns][:sandbox] = apns_sandbox
  end
end