class NotifiableAdmin::Admin < ActiveRecord::Base
  self.table_name = 'admins'
  
  devise :database_authenticatable, :lockable, :timeoutable, :rememberable, :trackable, :validatable, :invitable
  
  has_and_belongs_to_many :apps, :class_name => "Notifiable::App"
  belongs_to :account, :class_name => "NotifiableAdmin::Account"
    
  validates :apps, :length => { :minimum => 1, :message => "must include one at least one App"}, :if => :content_admin?

  def super_admin?
    role.eql? "super_admin"
  end
  
  def account_owner?
    role.eql? "account_owner"
  end
  
  def content_admin?
    role.eql? "content_admin"
  end
  
  def default_app
    self.account_owner? ? self.account.apps.first : self.apps.first
  end
  
end
