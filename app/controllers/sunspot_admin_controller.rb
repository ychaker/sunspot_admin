class SunspotAdminController < ApplicationController
  before_filter :has_access
  layout "susnpot_admin"
  
  def index
    @models = RailsSunspotAdmin.all_attributes
    get_status
  end
  
  # def make_searchable
  #   @not_prepared_items = SearchableItem.find_grouped_by_model_and_type  "searchable_status = '#{SearchableItem::NOTPREPARED}'"
  #   RailsSunspotAdmin.make_searchable @not_prepared_items
  #   SearchableItem.update_all( "searchable_status = '#{SearchableItem::PREPARED}'", "searchable_status = '#{SearchableItem::NOTPREPARED}'" )
  #   redirect_to :action => :index
  # end
  # 
  # def reindex
  #   @prepared_items = SearchableItem.find_grouped_by_model_and_type "searchable_status = '#{SearchableItem::PREPARED}'" 
  #   RailsSunspotAdmin.reindex @prepared_items.keys
  #   SearchableItem.update_all( "searchable_status = '#{SearchableItem::INDEXED}'", "searchable_status = '#{SearchableItem::PREPARED}'" )
  #   redirect_to :action => :index
  # end

  def reindex
    @items = SearchableItem.find_grouped_by_model_and_type
    setup_and_reindex @items
    respond_to do |format|
      format.html { redirect_to(:action => :index) }
      format.js {
        @models = RailsSunspotAdmin.all_attributes 
        get_status
      }
    end
  end
  
  def add_searchable_item
    @item = SearchableItem.new(params[:attribute])
    if @item.save
      respond_to do |format|
        format.html { redirect_to(:action => :index) }
        format.js { 
          get_status
        }
      end
    else
      flash[:error] = 'Error adding item.'
      redirect_to(:action => :index)
    end
  end
  
  def remove_searchable_item
    @item = SearchableItem.find(:first, :conditions => { 
      :searchable_model => params[:attribute][:searchable_model], 
      :searchable_field => params[:attribute][:searchable_field]
    })
    item = { :name => @item.searchable_model, :attribute => @item.searchable_field, :type => @item.searchable_field_type }
    @item.destroy
    @items = SearchableItem.find_grouped_by_model_and_type
    setup_and_reindex @items
    @item = item
    respond_to do |format|
      format.html { redirect_to(:action => :index) }
      format.js { 
        get_status
      }
    end
  end
  
  def start_solr
    Sunspot::Rails::Server.new.start
    while(starting)
    end
    sleep(10)
    ActiveRecord::Base.connection.reconnect! # Getting a mysql has gone away error for some reason!
    respond_to do |format|
      format.html { redirect_to(:action => :index) }
      format.js { 
        get_status
      }
    end    
  end
  
  def stop_solr
    Sunspot::Rails::Server.new.stop
    respond_to do |format|
      format.html { redirect_to(:action => :index) }
      format.js { 
        get_status
      }
    end
  end
 
private

  def get_status
    @unprepared = SearchableItem.status(SearchableItem::NOTPREPARED).by_model
    @prepared = SearchableItem.status(SearchableItem::PREPARED).by_model
    @indexed = SearchableItem.status(SearchableItem::INDEXED).by_model
    @added = ((@unprepared.to_a << @prepared.to_a).flatten << @indexed.to_a).flatten
    @searchable = RailsSunspotAdmin.search_enabled?
    @solr_running = RailsSunspotAdmin.solr_running?
  end
  
  def starting
    begin
      sleep(2)
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
