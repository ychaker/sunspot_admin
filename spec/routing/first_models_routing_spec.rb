require "spec_helper"

describe FirstModelsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/first_models" }.should route_to(:controller => "first_models", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/first_models/new" }.should route_to(:controller => "first_models", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/first_models/1" }.should route_to(:controller => "first_models", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/first_models/1/edit" }.should route_to(:controller => "first_models", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/first_models" }.should route_to(:controller => "first_models", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/first_models/1" }.should route_to(:controller => "first_models", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/first_models/1" }.should route_to(:controller => "first_models", :action => "destroy", :id => "1")
    end

  end
end
