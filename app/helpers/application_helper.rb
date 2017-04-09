module ApplicationHelper
  def render_icon(icon_class)
    content_tag :span do
      content_tag :i, '', class: icon_class, "aria-hidden": true
    end
  end
end
