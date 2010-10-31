require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
`rake db:migrate`

describe RailsSunspotAdmin do
  class Dummy < ActiveRecord::Base
  end
  
  describe '#list of items' do
    before(:each) do
      Factory.create(:dummy_name, :searchable_status => SearchableItem::NOTPREPARED)
      Factory.create(:dummy_description, :searchable_status => SearchableItem::PREPARED)
      Factory.create(:dummy_age, :searchable_status => SearchableItem::INDEXED)
    end
    
    it "should find all models and attributes for this app" do
      results = RailsSunspotAdmin.all_attributes
      results['Dummy'][:attributes].length.should == 6
    end
    
    it "should find all models and attributes for this app not yet added to search" do
      results = RailsSunspotAdmin.not_searchable
      results['Dummy'][:attributes].length.should == 3
    end
  end
  
  describe '#enable search' do
    it "should enable search for particular list of classes" do
      RailsSunspotAdmin.make_searchable({ 'Dummy' => { 'string' => [:name] } })
      Dummy.searchable?.should == true
    end
    
    it "should initialize search for models already added to index" do
      Factory.create(:dummy_age, :searchable_status => SearchableItem::INDEXED)
      RailsSunspotAdmin.initialize_search
      Dummy.searchable?.should == true
    end
  end
  
  describe '#solr' do
    it "should test if solr is running" do
      RailsSunspotAdmin.solr_running?.should == false
    end
    
    it "should test if the app is ready for search and return false if solr server is not started" do
      RailsSunspotAdmin.make_searchable({ 'Dummy' => { 'string' => [:name] } })
      RailsSunspotAdmin.search_enabled?.should == true
      RailsSunspotAdmin.ready?.should == false
    end
    
    describe '#running server' do
      before(:all) do
        CukeSunspot.new.start
      end
      
      it "should test if the app is ready for search and return true if solr server is started" do
        RailsSunspotAdmin.make_searchable({ 'Dummy' => { 'string' => [:name] } })
        RailsSunspotAdmin.search_enabled?.should == true
        RailsSunspotAdmin.solr_running?.should == true
        RailsSunspotAdmin.ready?.should == true
      end
    
      after(:all) do
        CukeSunspot.stop
      end
    end
  end
end