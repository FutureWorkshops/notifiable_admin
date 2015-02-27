module ApiAuthHelpers

  mattr_accessor :access_id
  mattr_accessor :secret_key

  def self.set_credentials(access_id, secret_key)
    self.access_id = access_id
    self.secret_key = secret_key
  end

  def self.reset_credentials
    self.access_id = nil
    self.secret_key = nil
  end
  
  Rack::Request.class_eval do
    def initialize(env)
      @env = env
      if ApiAuthHelpers.access_id && ApiAuthHelpers.secret_key && !@env["Content-MD5"]
        ApiAuth.sign!(self, ApiAuthHelpers.access_id, ApiAuthHelpers.secret_key)
      end  
    end
  end
  
end

