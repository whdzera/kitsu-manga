module AdminHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction =
      (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
    icon_class =
      if column == params[:sort]
        params[:direction] == "asc" ? "fa-sort-up" : "fa-sort-down"
      else
        "fa-sort"
      end

    link_to "#{title} <i class='fas #{icon_class}'></i>".html_safe,
            sort: column,
            direction: direction
  end
end
