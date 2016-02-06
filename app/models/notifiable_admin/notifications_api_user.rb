class NotifiableAdmin::NotificationsApiUser < ActiveRecord::Base
  self.table_name = 'notifications_api_users'
  
  devise :trackable, :lockable
  
  include ApiAuthenticatable
  
  has_and_belongs_to_many :apps, :class_name => "Notifiable::App"
  
  belongs_to :account
  
  validates :apps, :length => { :minimum => 1, :message => "must include one at least one App"}
  
  def enable
    update_attribute(:enabled, true)
  end
  
  def disable
    update_attribute(:enabled, false)
  end
  
  def require_authorization
    update_attribute(:authorization_required, true)    
  end
  
  def dont_require_authorization
    update_attribute(:authorization_required, false)   
  end
  
end
