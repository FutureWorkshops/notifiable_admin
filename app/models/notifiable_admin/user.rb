class NotifiableAdmin::User < ActiveRecord::Base
  self.table_name = 'users'
  
  notifiable
  
  belongs_to :app, class_name: "Notifiable::App"
  validates :app, presence: true
  
end
