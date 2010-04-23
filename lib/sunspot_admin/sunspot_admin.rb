module SunspotAdmin
  
  # Inject the searchable block for specified models and attributes
  # TODO: figure out a way to remove old searchable block
  # TODO: or user Sunspot.setup instead of the searchable block
  # Currently, removed fields will be indexed but omitted from searches through the search controller
  def self.make_searchable(klasses = {})
    klasses.each_pair do
      |klass, hash|
      Object.const_get(klass).class_eval do
        searchable do
          hash.each_pair do |type, items|
            # TODO: Use dynamic type instead of just 'string'
            # example: send type, items.collect { |each| each.field.to_sym }
            items.each do |item|
              text item.field.to_sym
            end
          end
        end
      end
    end
  end
  
  # Remove all indexed items for specified models and then reindex
  def self.reindex(klasses = [])
    Sunspot.remove_all!(klasses.collect{ |klass| Object.const_get(klass) })
    klasses.each { |klass| Object.const_get(klass).reindex }
    Sunspot.commit
  end
  
  # Check if any of the models is searchable
  # Helpful when server restarts
  def self.search_enabled?(klasses = [])
    klasses.each { |klass| 
      if Object.const_get(klass).searchable?
        return true
      end
    }
    return false
  end
  
end

