require 'spec_helper'

describe "first_models/index.html.erb" do
  before(:each) do
    assign(:first_models, [
      stub_model(FirstModel,
        :name => "Name",
        :description => "MyText",
        :number => 1
      ),
      stub_model(FirstModel,
        :name => "Name",
        :description => "MyText",
        :number => 1
      )
    ])
  end

  it "renders a list of first_models" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
