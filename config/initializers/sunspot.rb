# Make sure search is initialized on server restart
if SearchableItem.table_exists? 
  RailsSunspotAdmin.initialize_search
end