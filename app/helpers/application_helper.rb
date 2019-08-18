module ApplicationHelper
  def sortable(table, column, title)
    css_class = "#{table}.#{column}" == sort_column ? "current #{sort_direction}" : nil
    direction = "#{table}.#{column}" == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.permit(:search).merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end
end
