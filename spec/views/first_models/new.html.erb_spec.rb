require 'spec_helper'

describe "first_models/new.html.erb" do
  before(:each) do
    assign(:first_model, stub_model(FirstModel,
      :name => "MyString",
      :description => "MyText",
      :number => 1
    ).as_new_record)
  end

  it "renders new first_model form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => first_models_path, :method => "post" do
      assert_select "input#first_model_name", :name => "first_model[name]"
      assert_select "textarea#first_model_description", :name => "first_model[description]"
      assert_select "input#first_model_number", :name => "first_model[number]"
    end
  end
end
