class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_filter :validate_search_key, only: [:search]

  def index
    @jobs = case params[:order]
            when 'by_lower_bound'
              Job.published.order('wage_lower_bound DESC')
            when 'by_upper_bound'
              Job.published.order('wage_upper_bound DESC')
            else
              Job.published.recent
            end
  end

  def search
    @jobs = Job.where(id:-1)
    if @query_string.present?
      search_result = Job.ransack(@search_criteria).result(distinct: true)
      @jobs = search_result.paginate(page: params[:page], per_page: 20)
    end
    render :index

  end

  def show
    if @job.is_hidden
      redirect_to root_path, warning: "岗位已归档"
    end
  end

  # def new
  # @job = Job.new
  # end

  # def edit
  # end

  # def create
  # @job = Job.new(job_params)

  # if @job.save
  # redirect_to root_path
  # else
  # render :new
  # end
  # end

  # def update
  # if @job.update(job_params)
  # redirect_to root_path
  # else
  # render :edit, notice: "Update success"
  # end
  # end

  # def destroy
  # @job.destroy
  # redirect_to root_path, notice: "Job deleted"
  # end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :wage_lower_bound, 
                                :wage_upper_bound, :contact_email)
  end

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, '') if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end

  def search_criteria(query_string)
    { title_or_description_cont: query_string }

  end
end
