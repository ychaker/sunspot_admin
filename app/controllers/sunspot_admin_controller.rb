class SunspotAdminController < ApplicationController
  
  def index
    @models = RailsSunspotAdmin.not_searchable
    @unprepared = SearchableItem.status(SearchableItem::NOTPREPARED).by_model
    @prepared = SearchableItem.status(SearchableItem::PREPARED).by_model
    @indexed = SearchableItem.status(SearchableItem::INDEXED).by_model
    @ready = RailsSunspotAdmin.search_enabled?(SearchableItem.find_grouped_by_model_and_type.keys)
  end
  
  def make_searchable
    @not_prepared_items = SearchableItem.find_grouped_by_model_and_type
    RailsSunspotAdmin.make_searchable @not_prepared_items
    SearchableItem.update_all( "searchable_status = '#{SearchableItem::PREPARED}'", "searchable_status = '#{SearchableItem::NOTPREPARED}'" )
    redirect_to :action => :index
  end

  def reindex
    @prepared_items = SearchableItem.find_grouped_by_model_and_type
    RailsSunspotAdmin.reindex @prepared_items.keys
    SearchableItem.update_all( "searchable_status = '#{SearchableItem::INDEXED}'", "searchable_status = '#{SearchableItem::PREPARED}'" )
    redirect_to :action => :index
  end

  def make_searchable_and_reindex
    @not_prepared_items = SearchableItem.find_grouped_by_model_and_type
    RailsSunspotAdmin.make_searchable @not_prepared_items
    RailsSunspotAdmin.reindex @not_prepared_items.keys
    SearchableItem.update_all( "searchable_status = '#{SearchableItem::INDEXED}'", "searchable_status = '#{SearchableItem::NOTPREPARED}' OR searchable_status = '#{SearchableItem::PREPARED}'" )
    redirect_to :action => :index
  end
  
  def add_searchable_item
    @item = SearchableItem.new(params[:attribute])

    respond_to do |format|
      if @item.save
        flash[:notice] = 'Item was successfully added.'
        format.html { redirect_to(:action => :index) }
      else
        flash[:error] = 'Error adding item.'
        format.html { redirect_to(:action => :index) }
      end
    end
  end
  
  def remove_searchable_item
    @item = SearchableItem.find(params[:id])
    @item.destroy
    @not_prepared_items = SearchableItem.find_grouped_by_model_and_type
    RailsSunspotAdmin.make_searchable @not_prepared_items
    RailsSunspotAdmin.reindex @not_prepared_items.keys
    SearchableItem.update_all( "searchable_status = '#{SearchableItem::INDEXED}'", "searchable_status = '#{SearchableItem::NOTPREPARED}' OR searchable_status = '#{SearchableItem::PREPARED}'" )
    redirect_to(:action => :index)
  end
end
