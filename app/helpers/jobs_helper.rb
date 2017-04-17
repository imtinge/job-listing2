module JobsHelper
  def render_job_status(job)
    if job.is_hidden
      content_tag :a, nil, 
        class: 'btn btn-xs btn-default' do
        render_icon 'fa fa-lock'
      end
    else
      content_tag :a, nil, 
        class: 'btn btn-xs btn-default' do
        render_icon 'fa fa-unlock'
      end
    end
  end

  def render_highlight_content(content, query_string)
    excerpt_cont = excerpt(content, query_string, radius: 500)
    if excerpt_cont
      highlight(excerpt_cont, query_string)
    else
      content
    end
  end
end
