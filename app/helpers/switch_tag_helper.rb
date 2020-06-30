module SwitchTagHelper
  def switch_tag(name, label = nil, value = '1', checked = false, options = {})
    html_options = { 'type' => 'checkbox', 'name' => name, 'id' => sanitize_to_id(name), 'value' => value }.update(options.stringify_keys)
    html_options['checked'] = 'checked' if checked
    html_options['class'] = 'custom-control-input ' + html_options['class'].to_s
    content_tag(:div, class: 'custom-control custom-switch') do
      safe_join([
        tag(:input, html_options),
        (content_tag(:label, label, class: 'custom-control-label', for: "##{html_options['id']}") if label.present?)
      ])
    end
  end
end
