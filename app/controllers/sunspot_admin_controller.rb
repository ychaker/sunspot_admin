class SunspotAdminController < ApplicationController
  before_filter :has_access
  
  def index
    @models = RailsSunspotAdmin.not_searchable
    @unprepared = SearchableItem.status(SearchableItem::NOTPREPARED).by_model
    @prepared = SearchableItem.status(SearchableItem::PREPARED).by_model
    @indexed = SearchableItem.status(SearchableItem::INDEXED).by_model
    @searchable = RailsSunspotAdmin.search_enabled?
    @solr_running = RailsSunspotAdmin.solr_running?
  end
  
  def make_searchable
    @not_prepared_items = SearchableItem.find_grouped_by_model_and_type  "searchable_status = '#{SearchableItem::NOTPREPARED}'"
    RailsSunspotAdmin.make_searchable @not_prepared_items
    SearchableItem.update_all( "searchable_status = '#{SearchableItem::PREPARED}'", "searchable_status = '#{SearchableItem::NOTPREPARED}'" )
    redirect_to :action => :index
  end

  def reindex
    @prepared_items = SearchableItem.find_grouped_by_model_and_type "searchable_status = '#{SearchableItem::PREPARED}'" 
    RailsSunspotAdmin.reindex @prepared_items.keys
    SearchableItem.update_all( "searchable_status = '#{SearchableItem::INDEXED}'", "searchable_status = '#{SearchableItem::PREPARED}'" )
    redirect_to :action => :index
  end

  def make_searchable_and_reindex
    @items = SearchableItem.find_grouped_by_model_and_type
    setup_and_reindex @items
    redirect_to :action => :index
  end
  
  def add_searchable_item
    @item = SearchableItem.new(params[:attribute])
    if @item.save
      flash[:notice] = 'Item was successfully added.'
       redirect_to(:action => :index)
    else
      flash[:error] = 'Error adding item.'
      redirect_to(:action => :index)
    end
  end
  
  def remove_searchable_item
    @item = SearchableItem.find(params[:id])
    @item.destroy
    @items = SearchableItem.find_grouped_by_model_and_type
    setup_and_reindex @items
    redirect_to(:action => :index)
  end
  
  def start_solr
    Sunspot::Rails::Server.new.start
    while(starting)
    end
    redirect_to(:action => :index)
  end
  
  def stop_solr
    Sunspot::Rails::Server.new.stop
    redirect_to(:action => :index)
  end
 
private
  def starting
    begin
      sleep(1)
      request = Net::HTTP.get_response(URI.parse(Sunspot.config.solr.url))
      false
    rescue Errno::ECONNREFUSED
      true
    end
  end
  
  def setup_and_reindex items
    RailsSunspotAdmin.make_searchable items
    RailsSunspotAdmin.reindex items.keys
    SearchableItem.update_all( "searchable_status = '#{SearchableItem::INDEXED}'", "searchable_status = '#{SearchableItem::NOTPREPARED}' OR searchable_status = '#{SearchableItem::PREPARED}'" )
  end
  
  def has_access
    unless self.respond_to?(:current_user) && current_user.respond_to?(:is_admin?) && current_user.is_admin?
      render :text => "Access Denied!", :status => 401
    end
  end
end
