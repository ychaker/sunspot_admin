require 'spec_helper'

describe "second_models/edit.html.erb" do
  before(:each) do
    @second_model = assign(:second_model, stub_model(SecondModel,
      :new_record? => false,
      :name => "MyString",
      :description => "MyText",
      :number => 1
    ))
  end

  it "renders the edit second_model form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => second_model_path(@second_model), :method => "post" do
      assert_select "input#second_model_name", :name => "second_model[name]"
      assert_select "textarea#second_model_description", :name => "second_model[description]"
      assert_select "input#second_model_number", :name => "second_model[number]"
    end
  end
end
