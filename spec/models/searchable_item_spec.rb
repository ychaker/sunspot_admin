require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SearchableItem do
  
  fixtures :searchable_items
  
  before(:each) do
    @valid_attributes = {
      :model => "value for model",
      :field => "value for field",
      :field_type => "value for type"
    }
    
    @item1 = searchable_items(:one)
  end

  it "should create a new instance given valid attributes" do
    SearchableItem.create!(@valid_attributes)
  end
  
  it "should make sure duplicates are not created" do
    item = SearchableItem.new(@item1.attributes)
    item.valid?.should == false
  end
end
