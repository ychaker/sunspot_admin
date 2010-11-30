require "net/http"

module RailsSunspotAdmin
  Dir.glob(Rails.root.to_s + '/app/models/**/*.rb').each { |file| require file }
  
  # find all models and attributes for this app
  def self.all_attributes
    RailsSunspotAdmin.app_attributes_by_model "column.name == 'id'"
  end

  # find all models and attributes for this app not yet added to SearchableItem table
  def self.not_searchable
    RailsSunspotAdmin.app_attributes_by_model "column.name == 'id' || SearchableItem.exists?(:searchable_model => app_model.name, :searchable_field => column.name)"
  end

  # get all attributes grouped by model
  def self.app_attributes_by_model conditions=false
    @models =  {}
    ActiveRecord::Base.send(:descendants).each do |app_model|
      unless app_model.name == "ActiveRecord::SessionStore::Session" || app_model.name == "SearchableItem"
        @models[app_model.name] = {}
        @models[app_model.name][:searchable_model] = app_model 
        @models[app_model.name][:attributes] = {}
        app_model.columns.each{ |column| 
          unless eval(conditions)
            @models[app_model.name][:attributes][column.name] = column.type
          end
        }
      end
    end
    @models
  end
  
  # Inject the searchable block for specified models and attributes
  # Currently, removed fields will be indexed but omitted from searches through the search controller
  # klasses => 'User' => { 'string' => [:name, :initials], 'integer' => [:age] }
  # field types: text, string, integer, float, time, boolean
  # index all fields as text fields in order to make them searchable
  def self.make_searchable(klasses = {})
    klasses.each_pair do # 'User' => { 'string' => [:name, :initials], 'integer' => [:age] }
      |klass, hash|
      # klass = 'User'
      # hash = { 'string' => [:name, :initials], 'integer' => [:age] }
      Object.const_get(klass).class_eval do
        searchable do
          hash.each_pair do |type, fields|
            case type
            when 'string'
              string *fields
            when 'integer'
              integer *fields
            when 'float'
              float *fields
            when 'time', 'date', 'datetime'
              time *fields
            when 'boolean'
              boolean *fields
            else # text, string, or any other non supported type
              text *fields
            end
          end
          all_fields = hash.each_key.inject([]) {|result, each| result << hash[each] }.flatten
          text *all_fields
        end
      end
    end
  end
  
  # initialize search for items already added to the index
  # used when server restarts and model classes lose searchable block previously injected
  def self.initialize_search
    RailsSunspotAdmin.make_searchable SearchableItem.find_grouped_by_model_and_type  "searchable_status = '#{SearchableItem::INDEXED}'"
  end
  
  # Remove all indexed items for specified models and then reindex
  def self.reindex(klasses = [])
    Sunspot.remove_all!(klasses.collect{ |klass| Object.const_get(klass) })
    klasses.each { |klass| Object.const_get(klass).reindex }
    Sunspot.commit
  end
  
  # Check if any of the models is searchable
  # Helpful when server restarts
  def self.search_enabled?
    klasses = ActiveRecord::Base.send(:descendants).map { |each| each.name }
    klasses.each { |klass| 
      if Object.const_get(klass).searchable?
        return true
      end unless klass  == "ActiveRecord::SessionStore::Session" || klass == "SearchableItem"
    }
    return false
  end
  
  # Check if the solr server is running
  def self.solr_running?
    begin
      request = Net::HTTP.get_response(URI.parse(Sunspot.config.solr.url))
      return true
    rescue Errno::ECONNREFUSED
      return false
    end
  end
  
  def self.ready?
    return RailsSunspotAdmin.solr_running? && RailsSunspotAdmin.search_enabled?
  end
  
end

