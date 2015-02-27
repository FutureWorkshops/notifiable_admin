module ApiAuthenticatable
  extend ActiveSupport::Concern
  
  included do
    before_save :ensure_api_credentials
  end
  
  def ensure_api_credentials
    self.access_id = generate_access_id if access_id.blank?
    self.secret_key = generate_secret_key if secret_key.blank?
  end

  private
    def generate_access_id
      loop do
        token = Devise.friendly_token
        break token unless self.class.where(access_id: token).first
      end
    end
    
    def generate_secret_key
      loop do
        token = ApiAuth.generate_secret_key
        break token unless self.class.where(secret_key: token).first
      end
    end
  
end