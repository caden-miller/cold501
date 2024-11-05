# app/helpers/application_helper.rb
module ApplicationHelper
  def sortable(column, title = nil, css_class = nil)
    title ||= column.titleize
    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
    link_to title, { sort: column, direction: direction }, class: css_class
    if column == params[:sort]
      if params[:direction] == "asc"
        link_to "#{title} ↑", { sort: column, direction: "desc" }, class: css_class
      else
        link_to "#{title} ↓", { sort: column, direction: "asc" }, class: css_class
      end
    else
      link_to title, { sort: column, direction: "asc" }, class: css_class
    end
  end
end
