class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  def index
    @jobs = Job.all
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
      redirect_to root_path
    else
      render :new
    end
  end

  def udpate
    if @job.update(job_params)
      redirect_to root_path
    else
      render :edit, notice: "Update success"
    end
  end

  def destroy
    @job.destroy
    redirect_to root_path, notice: "Job deleted"
  end

  private
    
    def set_job
      @job = Job.find(params[:id])
    end
    
    def job_params
      params.require(:job).permit(:title, :description)
    end
end
