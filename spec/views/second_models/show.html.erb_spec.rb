require 'spec_helper'

describe "second_models/show.html.erb" do
  before(:each) do
    @second_model = assign(:second_model, stub_model(SecondModel,
      :name => "Name",
      :description => "MyText",
      :number => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
