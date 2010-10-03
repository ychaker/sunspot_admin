class SearchableItem < ActiveRecord::Base
  validates_uniqueness_of(:searchable_field, :scope => :searchable_model)
  
  NOTPREPARED = 1
  PREPARED    = 2
  INDEXED     = 3

  # Return a hash of attributes to index grouped by model name and type
  # to make it easy to loop through the list and make the models 'searchable'
  def self.find_grouped_by_model_and_type *conditions
    all = SearchableItem.find :all, *conditions
    @grouped = {}
    all.each do |item|
      @grouped[item.searchable_model] =  @grouped[item.searchable_model].blank? ? {} : @grouped[item.searchable_model]
      @grouped[item.searchable_model][item.searchable_field_type] = @grouped[item.searchable_model][item.searchable_field_type].blank? ? [] : @grouped[item.searchable_model][item.searchable_field_type]
      @grouped[item.searchable_model][item.searchable_field_type] << item
    end
    @grouped
  end
  
  # find all models and attributes for this app
  def self.find_app_models_and_attributes
    @models =  {}
    ActiveRecord::Base.send(:subclasses).each do |model|
      unless model.name == "ActiveRecord::SessionStore::Session" || model.name == "SearchableItem"
        @models[model.name] = {}
        @models[model.name][:searchable_model] = model
        @models[model.name][:attributes] = {}
        model.columns.each{ |each| 
          unless each.name == "id"
            @models[model.name][:attributes][each.name] = each.type
          end
        }
      end
    end
    @models
  end
  
  # find all models and attributes for this app not yet added to search
  def self.find_nonsearchable_app_models_and_attributes
    @models =  {}
    ActiveRecord::Base.send(:subclasses).each do |model|
      unless model.name == "ActiveRecord::SessionStore::Session" || model.name == "SearchableItem"
        @models[model.name] = {}
        @models[model.name][:searchable_model] = model
        @models[model.name][:attributes] = {}
        model.columns.each{ |each| 
          unless each.name == "id" || SearchableItem.exists?(:searchable_model => model.name, :searchable_field => each.name)
            @models[model.name][:attributes][each.name] = each.type
          end
        }
      end
    end
    @models
  end
  
  # find all the fields to search on
  def self.find_searchable_fields
    SearchableItem.find(:all).collect { |each| each.searchable_field.to_sym }.uniq
  end
end
