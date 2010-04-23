module SearchHelper
  def search_item_link item, text = "more"
    link_to text, :action => :show, :controller => item.class.name.downcase.pluralize.to_sym, :id => item.id
  end
  
  # Try to guess what attribute to use as the item's title
  def item_title item, title_attribute = nil
    if title_attribute
      item.send(title_attribute)
    else
      columns = item.class.column_names
      if columns.include?('name')
        item.send('name')
      elsif columns.include?('title')
        item.send('title')
      else
        "Title not available"
      end
    end
  end
  
  def display_result item, hit
    begin
      render :partial => "display_result_#{item.class.name.downcase}", :locals => {:item => item, :hit => hit }
    rescue ActionView::MissingTemplate
      render :partial => "default_display_result", :locals => {:item => item, :hit => hit }
    end
  end
end
