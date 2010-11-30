module SunspotAdminHelper
  def display_model_name name
    name.underscore.gsub(/_/, " ")
  end
  
  def idify_model_name name
    name.underscore.dasherize.downcase
  end
  
  def display_item_add_button item, added_check
    added = added_check == true ? 'button_on' : 'button_off'
    if added_check
			link_to raw("
			<div class='add_button #{added}'>
				<div class='add_button_outer'>
					<div class='add_button_center_border'>
							<div class='button_text add_button_center'>
									<strong>add</strong>
							</div><!--add_button_center_on-->
					</div><!--add_button_center_border_on-->
				</div><!--add_button_on-->
			</div> <!--add_button-->
			"), :action => :remove_searchable_item, :controller => :sunspot_admin, 
			:attribute => {
				:searchable_model => item[:name],
				:searchable_field => item[:attribute]
			}
		else
		  link_to raw("
			<div class='add_button #{added}'>
				<div class='add_button_outer'>
					<div class='add_button_center_border'>
							<div class='button_text add_button_center'>
									<strong>add</strong>
							</div><!--add_button_center_on-->
					</div><!--add_button_center_border_on-->
				</div><!--add_button_on-->
			</div> <!--add_button-->
			"), :action => :add_searchable_item, :controller => :sunspot_admin, 
			:attribute => { 
				:searchable_model => item[:name],
				:searchable_field => item[:attribute],
				:searchable_field_type => item[:type],
				:searchable_status => SearchableItem::NOTPREPARED
			}
		end
	end
	
	def display_item_indexed_light item, indexed
		"<div class='indexed_light #{indexed}'>
			<div class='button_text text'>
				indexed
			</div><!--button_text text-->
		</div> <!--indexed_light_on-->"
  end
  
  def display_item_display item, indexed
    display = "#{item[:attribute].humanize}:#{item[:type]}"
    display = display.length > 18 ? display[0..14] << "..." : display
		"<div class='#{indexed}_item'>
			<div class='item_display'>
				<div class='text'><strong>#{display.underscore.gsub(/ /, '_')}</strong></div>
			</div><!--item display-->
		</div> <!--indexed-->"
  end
end
