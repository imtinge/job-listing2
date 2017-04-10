module JobsHelper
  def render_job_status(job)
    if job.is_hidden
      content_tag :a, '', class: 'btn btn-xs btn-default' do
        render_icon 'fa fa-lock'
      end
    else
      content_tag :a, '', class: 'btn btn-xs btn-default' do
        render_icon 'fa fa-unlock'
      end
    end
  end
end
