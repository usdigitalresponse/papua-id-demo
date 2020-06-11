module DescisionHelper
  def descision_icon(descision, options={})
    case descision
    when 'Approved'
      text_class = 'text-success'
      icon_class = 'fas fa-check-circle'
    when 'Denied'
      text_class = 'text-danger'
      icon_class = 'fas fa-times-circle'
    when 'Manual Review'
      text_class = 'text-warning'
      icon_class = 'fas fa-user-circle'
    end
    icon_class << " fa-#{options[:size]}x" if options[:size].present?
    content_tag(:span, content_tag(:i, '', class: icon_class), class: text_class)
  end
end
