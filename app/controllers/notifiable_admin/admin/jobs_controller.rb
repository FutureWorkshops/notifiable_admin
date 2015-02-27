class NotifiableAdmin::Admin::JobsController <NotifiableAdmin::Admin::BaseController

  load_and_authorize_resource :app, :class => "Notifiable::App"
  load_and_authorize_resource :job, :class => "Delayed::Job"
  
  before_filter :find_jobs, :only => :index

  def index
    authorize! :read, Delayed::Job
    authorize! :read, @app
    
    @jobs = @jobs.order(:run_at).page(params[:page])
  end
  
  def destroy
    if @job.destroy && Notifiable::Notification.find(@job.notification_id).destroy
      redirect_to admin_account_app_jobs_path(@account, @app), notice: "Notification was deleted."
    else
      redirect_to admin_account_app_jobs_path(@account, @app), alert: @job.errors.full_messages.to_sentence
    end
  end
  
  private
  def find_jobs
    @jobs = Delayed::Job.where(:app_id => params[:app_id])
  end
  
end