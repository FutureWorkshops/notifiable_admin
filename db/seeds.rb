def fake_device_token(provider, app)
  d = Notifiable::DeviceToken.create!(provider: provider, :token => Faker::Bitcoin.address, :app => app)
  d.update_attribute(:created_at, Faker::Time.between(365.days.ago, Time.now))
end

def fake_notification(app)
  sent_count = SecureRandom.random_number(app.device_tokens.count)
  sent_count += 1 if sent_count == 0
  gateway_accepted_count = SecureRandom.random_number(sent_count)
  gateway_accepted_count += 1 if gateway_accepted_count == 0
  opened_count = SecureRandom.random_number(gateway_accepted_count)
  
  n = Notifiable::Notification.create!(:app => app, :opened_count => opened_count, :sent_count => sent_count, :gateway_accepted_count => gateway_accepted_count)
  Notifiable::LocalizedNotification.create!(:notification => n, :message => Faker::Company.catch_phrase, :params => nil)
  
  n.update_attribute(:created_at, Faker::Time.between(365.days.ago, Time.now))
end

def fake_data(app)
  SecureRandom.random_number(1000).times { fake_device_token(:apns, app) }
  SecureRandom.random_number(500).times { fake_device_token(:gcm, app) }
  SecureRandom.random_number(100).times { fake_device_token(:mpns, app) }
  SecureRandom.random_number(1000).times { fake_notification(app) }
end

if Admin.count == 0

  account = Account.create! :name => "Future Workshops"
  Notifiable::App.create!([{:name => "PushTest", :account => account}, {:name => "PushTest2", :account => account}])

  elm = Account.create! :name => "MOI"
  Notifiable::App.create!([{:name => "iMOI", :account => elm}, {:name => "Hajj", :account => elm}])

  Admin.create! :email => "mbs@futureworkshops.com", :password => "London123", :role => "super_admin"
  Admin.create! :email => "matt@futureworkshops.com", :password => "London123", :role => "account_owner", :account => account
  Admin.create! :email => "mchaudhry@elm.sa", :password => "London123", :role => "account_owner", :account => elm
  
  content_admin = Admin.new :email => "fabio@futureworkshops.com", :password => "London123", :role => "content_admin", :account => account
  content_admin.apps << Notifiable::App.first
  content_admin.save!
  
  Notifiable::App.all.each do |app|
    fake_data(app)
  end

end

