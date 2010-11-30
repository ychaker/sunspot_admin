class SearchableItem < ActiveRecord::Base
  validates_uniqueness_of :searchable_field, :scope => :searchable_model
  validates_presence_of :searchable_model, :searchable_field, :searchable_field_type

  scope :status,   proc {|status| where(:searchable_status => status) }
  scope :by_model, order(:searchable_model)
  
  NOTPREPARED = 1
  PREPARED    = 2
  INDEXED     = 3

  # Return a hash of attributes to index grouped by model name and type
  # to make it easy to loop through the list and make the models 'searchable'
  # Example: 'User' => { 'string' => [:name, :initials], 'integer' => [:age] }
  def self.find_grouped_by_model_and_type conditions = []
    all = SearchableItem.where(conditions)
    @grouped = {}
    all.each do |item|
      @grouped[item.searchable_model] =  @grouped[item.searchable_model].blank? ? {} : @grouped[item.searchable_model]
      @grouped[item.searchable_model][item.searchable_field_type] = @grouped[item.searchable_model][item.searchable_field_type].blank? ? [] : @grouped[item.searchable_model][item.searchable_field_type]
      @grouped[item.searchable_model][item.searchable_field_type] << item.searchable_field.to_sym
    end
    @grouped
  end
  
  # find all the fields to search on
  def self.searchable_fields
    SearchableItem.status(SearchableItem::INDEXED).collect { |each| each.searchable_field.to_sym }.uniq
  end
  
  def is_model_and_attribute model_name, attribute_name
    self.searchable_model == model_name && self.searchable_field == attribute_name
  end
end
