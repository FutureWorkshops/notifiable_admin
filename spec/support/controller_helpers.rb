module ControllerHelpers
  def admin_sign_in(admin = double('admin'))
    if admin.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :admin})
      allow(controller).to receive(:current_admin).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
      allow(controller).to receive(:current_admin).and_return(admin)
    end
  end
end

# Raise exceptions that occur
ActionController::Base.class_eval do
  def rescue_action(exception)
    raise exception
  end
end