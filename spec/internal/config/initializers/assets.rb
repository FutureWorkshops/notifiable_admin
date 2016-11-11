# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.precompile += %w( notifiable_admin/main.css notifiable_admin/main.js login.css dashboard.css dashboard.js)

Rails.application.config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

