class NotifiableAdmin::User < ActiveRecord::Base
  self.table_name = 'users'
  
  notifiable
  
  scope :for_app, ->(app) { joins('LEFT OUTER JOIN notifiable_device_tokens ON notifiable_device_tokens.user_id = users.id').where('notifiable_device_tokens.app_id = ?', app.id) }
end
