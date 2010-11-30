require "spec_helper"

describe SecondModelsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/second_models" }.should route_to(:controller => "second_models", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/second_models/new" }.should route_to(:controller => "second_models", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/second_models/1" }.should route_to(:controller => "second_models", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/second_models/1/edit" }.should route_to(:controller => "second_models", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/second_models" }.should route_to(:controller => "second_models", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/second_models/1" }.should route_to(:controller => "second_models", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/second_models/1" }.should route_to(:controller => "second_models", :action => "destroy", :id => "1")
    end

  end
end
