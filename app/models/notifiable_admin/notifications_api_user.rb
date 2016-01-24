class NotifiableAdmin::NotificationsApiUser < ActiveRecord::Base
  self.table_name = 'notifications_api_users'
  
  devise :trackable, :lockable
  
  include ApiAuthenticatable
  
  has_and_belongs_to_many :apps, :class_name => "Notifiable::App"
  
  belongs_to :account
  
  validates :apps, :length => { :minimum => 1, :message => "must include one at least one App"}
  
  def enable
    self.enabled = true
    self.save
  end
  
  def disable
    self.enabled = false
    self.save
  end
  
end
