class SunspotAdminController < ApplicationController
  
  def index
    Dir.glob(RAILS_ROOT + '/app/models/**/*.rb').each { |file| require file }
    @models = SearchableItem.find_nonsearchable_app_models_and_attributes
    @unprepared = SearchableItem.find(:all, :conditions => {:status => SearchableItem::NOTPREPARED}, :order => :model)
    @prepared = SearchableItem.find(:all, :conditions => {:status => SearchableItem::PREPARED}, :order => :model)
    @indexed = SearchableItem.find(:all, :conditions => {:status => SearchableItem::INDEXED}, :order => :model)
    @ready = SunspotAdmin.search_enabled?(SearchableItem.find_grouped_by_model_and_type.keys)
  end
  
  def make_searchable
    @not_prepared_items = SearchableItem.find_grouped_by_model_and_type
    SunspotAdmin.make_searchable @not_prepared_items
    SearchableItem.update_all( "status = '#{SearchableItem::PREPARED}'", "status = '#{SearchableItem::NOTPREPARED}'" )
    redirect_to :action => :index
  end

  def reindex
    @prepared_items = SearchableItem.find_grouped_by_model_and_type
    SunspotAdmin.reindex @prepared_items.keys
    SearchableItem.update_all( "status = '#{SearchableItem::INDEXED}'", "status = '#{SearchableItem::PREPARED}'" )
    redirect_to :action => :index
  end

  def make_searchable_and_reindex
    @not_prepared_items = SearchableItem.find_grouped_by_model_and_type
    SunspotAdmin.make_searchable @not_prepared_items
    SunspotAdmin.reindex @not_prepared_items.keys
    SearchableItem.update_all( "status = '#{SearchableItem::INDEXED}'", "status = '#{SearchableItem::NOTPREPARED}' OR status = '#{SearchableItem::PREPARED}'" )
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
    SunspotAdmin.make_searchable @not_prepared_items
    SunspotAdmin.reindex @not_prepared_items.keys
    SearchableItem.update_all( "status = '#{SearchableItem::INDEXED}'", "status = '#{SearchableItem::NOTPREPARED}' OR status = '#{SearchableItem::PREPARED}'" )
    redirect_to(:action => :index)
  end
end
