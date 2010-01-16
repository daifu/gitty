# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def make_selected_link(name, link)
    link_to_unless_current(name, link) do
      link_to name, link, :class => "active"
    end
  end
  
  
end
