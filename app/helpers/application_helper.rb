# frozen_string_literal: true

# Helper methods for the application
module ApplicationHelper
  # Creates a sortable link for table headers
  def sortable(column, title = nil, css_class = nil)
    title ||= column.titleize
    direction = toggle_direction(column)
    text = sortable_title(title, column)

    link_to text, { sort: column, direction: }, class: css_class
  end

  private

  # Toggles the sorting direction based on the current params
  def toggle_direction(column)
    column == params[:sort] && params[:direction] == 'asc' ? 'desc' : 'asc'
  end

  # Formats the title with an arrow indicating the current sort direction
  def sortable_title(title, column)
    return "#{title} ↑" if column == params[:sort] && params[:direction] == 'asc'
    return "#{title} ↓" if column == params[:sort] && params[:direction] == 'desc'

    title
  end
end
