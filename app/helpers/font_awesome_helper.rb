module FontAwesomeHelper
  def fa_icon(icon, options = {})
    options[:class] ||= ''
    options[:variant] ||= :fas
    options[:class] << " #{options.delete(:variant)} fa-#{icon.to_s.dasherize}"
    options[:class] << " fa-#{options.delete(:size)}"
    content_tag(:i, '', options)
  end
end
