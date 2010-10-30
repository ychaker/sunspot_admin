require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SearchableItem do
  
  describe "#create" do
    it "should create a new instance given valid attributes" do
      Factory.create(:user_name)
    end
  
    it "should make sure duplicates are not created" do
      first = Factory.build(:user_name)
      first.save
      second = Factory.build(:user_name)
      second.should have(1).errors_on(:searchable_field)
    end
    
    it "should require a searchable model" do
      invalid = Factory.build(:user_name, :searchable_model => nil)
      invalid.should have(1).errors_on(:searchable_model)
    end
    
    it "should require a searchable field" do
      invalid = Factory.build(:user_name, :searchable_field => nil)
      invalid.should have(1).errors_on(:searchable_field)
    end
    
    it "should require a searchable type" do
      invalid = Factory.build(:user_name, :searchable_field_type => nil)
      invalid.should have(1).errors_on(:searchable_field_type)
    end
  end
  
  describe "#find" do
    before(:each) do
      Factory.create(:user_name, :searchable_status => SearchableItem::INDEXED)
      Factory.create(:user_initials, :searchable_status => SearchableItem::INDEXED)
      Factory.create(:company_name, :searchable_status => SearchableItem::INDEXED)
    end
    
    it "should return all unique searchable fields" do
      SearchableItem.searchable_fields.length.should == 2
    end
    
    it "should return a hash of searchable items grouped by model name and type" do
      results = SearchableItem.find_grouped_by_model_and_type
      results.keys.length.should == 2
    end
    
    it "should return a hash of searchable items grouped by model name and type where model name is not Company" do
      results = SearchableItem.find_grouped_by_model_and_type ["searchable_model != ?", "Company"] 
      results.keys.length.should == 1
    end
  end
  
  describe "#scope" do
    before(:each) do
      Factory.create(:user_name, :searchable_status => SearchableItem::NOTPREPARED)
      Factory.create(:user_initials, :searchable_status => SearchableItem::PREPARED)
      Factory.create(:company_name, :searchable_status => SearchableItem::INDEXED)
    end
    it "should return only searchable items where searchable status is SeachableItem::NOTPREPARED" do
      SearchableItem.status(SearchableItem::NOTPREPARED).length.should == 1
    end
    
    it "should return only searchable items where searchable status is SeachableItem::PREPARED" do
      SearchableItem.status(SearchableItem::PREPARED).length.should == 1
    end
    
    it "should return only searchable items where searchable status is SeachableItem::INDEXED" do
      SearchableItem.status(SearchableItem::INDEXED).length.should == 1
    end
  end
end
