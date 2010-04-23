class SearchableItem < ActiveRecord::Base
  validates_uniqueness_of(:field, :scope => :model)
  
  NOTPREPARED = 1
  PREPARED    = 2
  INDEXED     = 3

  # Return a hash of attributes to index grouped by model name and type
  # to make it easy to loop through the list and make the models 'searchable'
  def self.find_grouped_by_model_and_type *conditions
    all = SearchableItem.find :all, *conditions
    @grouped = {}
    all.each do |item|
      @grouped[item.model] =  @grouped[item.model].blank? ? {} : @grouped[item.model]
      @grouped[item.model][item.field_type] = @grouped[item.model][item.field_type].blank? ? [] : @grouped[item.model][item.field_type]
      @grouped[item.model][item.field_type] << item
    end
    @grouped
  end
  
  # find all models and attributes for this app
  def self.find_app_models_and_attributes
    @models =  {}
    ActiveRecord::Base.send(:subclasses).each do |model|
      unless model.name == "ActiveRecord::SessionStore::Session" || model.name == "SearchableItem"
        @models[model.name] = {}
        @models[model.name][:model] = model
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
        @models[model.name][:model] = model
        @models[model.name][:attributes] = {}
        model.columns.each{ |each| 
          unless each.name == "id" || SearchableItem.exists?(:model => model.name, :field => each.name)
            @models[model.name][:attributes][each.name] = each.type
          end
        }
      end
    end
    @models
  end
  
  # find all the fields to search on
  def self.find_searchable_fields
    SearchableItem.find(:all).collect { |each| each.field.to_sym }.uniq
  end
end
