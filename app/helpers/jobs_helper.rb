module JobsHelper
  def render_job_status(job)
    if job.is_hidden
      content_tag :a, '', class: 'btn btn-xs btn-default' do
        render_icon 'fa fa-eye-slash'
      end
    else
      content_tag :a, '', class: 'btn btn-xs btn-success' do
        render_icon 'fa fa-eye'
      end
    end
  end
end
