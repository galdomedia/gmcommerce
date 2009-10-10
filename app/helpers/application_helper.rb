# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def yield_or_default(message, default_message = "")
    message.nil? ? default_message : message
  end

  def tab_to(name, all_options = nil)
    url = all_options.is_a?(Array) ? all_options[0].merge({:only_path => false}) : "#"

    current_url = url_for(:action => @current_action, :only_path => false)
    html_options = {}

    if all_options.is_a?(Array)
      all_options.each do |o|
        if url_for(o.merge({:only_path => false})) == current_url
          html_options = {:class => "current"}
          break
        end
      end
    end

    link_to(name, url, html_options)
  end

  
end
