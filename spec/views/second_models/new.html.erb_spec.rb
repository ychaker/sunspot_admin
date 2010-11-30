require 'spec_helper'

describe "second_models/new.html.erb" do
  before(:each) do
    assign(:second_model, stub_model(SecondModel,
      :name => "MyString",
      :description => "MyText",
      :number => 1
    ).as_new_record)
  end

  it "renders new second_model form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => second_models_path, :method => "post" do
      assert_select "input#second_model_name", :name => "second_model[name]"
      assert_select "textarea#second_model_description", :name => "second_model[description]"
      assert_select "input#second_model_number", :name => "second_model[number]"
    end
  end
end
