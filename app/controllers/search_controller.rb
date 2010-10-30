class SearchController < ApplicationController
  before_filter :check_init
  
  def index
    @klasses = SearchableItem.find_grouped_by_model_and_type.keys
    if params[:model].blank? || params[:model] == 'All'
      @search = Sunspot.search(@klasses.collect { |klass| Object.const_get(klass) }) do
        keywords(params[:q])#, :fields =>  SearchableItem.searchable_fields)
        paginate :page => params[:page], :per_page => 15
      end
    else
      @search = Sunspot.search(Object.const_get(params[:model])) do
        keywords(params[:q])
        paginate :page => params[:page], :per_page => 15
      end
    end
  end

private
  def check_init
    unless RailsSunspotAdmin.ready?
      render "not_ready"
      return
    end
  end
end
