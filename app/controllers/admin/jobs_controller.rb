class Admin::JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  before_action :set_job, only: [:show, :edit, :update, :destroy, :publish, :hide]

  layout 'admin'

  def index
    @jobs = Job.order('created_at DESC')
  end

  def new
    @job = Job.new
  end

  def show

  end

  def edit

  end

  def create
    @job = Job.new(job_params)
    
    if @job.save
      redirect_to admin_jobs_path
    else
      render :new
    end
  end

  def update
    if @job.update(job_params)
      redirect_to admin_jobs_path
    else
      render :edit, notice: "Update success"
    end
  end

  def destroy
    @job.destroy
    redirect_to admin_jobs_path, notice: "Job deleted"
  end

  def publish
    if @job.is_hidden
      @job.publish!
    end
    redirect_to :back
  end

  def hide
    unless @job.is_hidden
      @job.hide!
    end
    redirect_to :back
  end

  private
    
    def set_job
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:title, :description, :wage_lower_bound, 
                                 :wage_upper_bound, :contact_email, :is_hidden)
    end
end
