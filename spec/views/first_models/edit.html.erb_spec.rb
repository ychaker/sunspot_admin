require 'spec_helper'

describe "first_models/edit.html.erb" do
  before(:each) do
    @first_model = assign(:first_model, stub_model(FirstModel,
      :new_record? => false,
      :name => "MyString",
      :description => "MyText",
      :number => 1
    ))
  end

  it "renders the edit first_model form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => first_model_path(@first_model), :method => "post" do
      assert_select "input#first_model_name", :name => "first_model[name]"
      assert_select "textarea#first_model_description", :name => "first_model[description]"
      assert_select "input#first_model_number", :name => "first_model[number]"
    end
  end
end
