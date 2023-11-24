module ApplicationHelper
  def toggle_direction(column_key)
    if column_key == params[:sort] && params[:direction] == 'asc'
      'desc'
    else
      'asc'
    end
  end
end
