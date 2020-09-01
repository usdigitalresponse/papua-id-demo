module SortLinkHelper
  def link_to_sort(column_text, column_name)
    dir = 'ASC'
    dir = 'DESC' if (params[:dir] == 'ASC' && column_name.to_s == params[:sort])
    return link_to sort: column_name, dir: dir do
      [
        content_tag(:span, column_text),
        (params[:dir] == 'ASC' ? fa_icon(:sort_amount_down_alt, size: 'sm') : fa_icon(:sort_amount_down, size: 'sm') if column_name.to_s == params[:sort])
      ].join(' ').html_safe
    end
  end
end
