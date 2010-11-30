require 'spec_helper'

describe FirstModelsController do

  def mock_first_model(stubs={})
    (@mock_first_model ||= mock_model(FirstModel).as_null_object).tap do |first_model|
      first_model.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all first_models as @first_models" do
      FirstModel.stub(:all) { [mock_first_model] }
      get :index
      assigns(:first_models).should eq([mock_first_model])
    end
  end

  describe "GET show" do
    it "assigns the requested first_model as @first_model" do
      FirstModel.stub(:find).with("37") { mock_first_model }
      get :show, :id => "37"
      assigns(:first_model).should be(mock_first_model)
    end
  end

  describe "GET new" do
    it "assigns a new first_model as @first_model" do
      FirstModel.stub(:new) { mock_first_model }
      get :new
      assigns(:first_model).should be(mock_first_model)
    end
  end

  describe "GET edit" do
    it "assigns the requested first_model as @first_model" do
      FirstModel.stub(:find).with("37") { mock_first_model }
      get :edit, :id => "37"
      assigns(:first_model).should be(mock_first_model)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created first_model as @first_model" do
        FirstModel.stub(:new).with({'these' => 'params'}) { mock_first_model(:save => true) }
        post :create, :first_model => {'these' => 'params'}
        assigns(:first_model).should be(mock_first_model)
      end

      it "redirects to the created first_model" do
        FirstModel.stub(:new) { mock_first_model(:save => true) }
        post :create, :first_model => {}
        response.should redirect_to(first_model_url(mock_first_model))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved first_model as @first_model" do
        FirstModel.stub(:new).with({'these' => 'params'}) { mock_first_model(:save => false) }
        post :create, :first_model => {'these' => 'params'}
        assigns(:first_model).should be(mock_first_model)
      end

      it "re-renders the 'new' template" do
        FirstModel.stub(:new) { mock_first_model(:save => false) }
        post :create, :first_model => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested first_model" do
        FirstModel.should_receive(:find).with("37") { mock_first_model }
        mock_first_model.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :first_model => {'these' => 'params'}
      end

      it "assigns the requested first_model as @first_model" do
        FirstModel.stub(:find) { mock_first_model(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:first_model).should be(mock_first_model)
      end

      it "redirects to the first_model" do
        FirstModel.stub(:find) { mock_first_model(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(first_model_url(mock_first_model))
      end
    end

    describe "with invalid params" do
      it "assigns the first_model as @first_model" do
        FirstModel.stub(:find) { mock_first_model(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:first_model).should be(mock_first_model)
      end

      it "re-renders the 'edit' template" do
        FirstModel.stub(:find) { mock_first_model(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested first_model" do
      FirstModel.should_receive(:find).with("37") { mock_first_model }
      mock_first_model.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the first_models list" do
      FirstModel.stub(:find) { mock_first_model }
      delete :destroy, :id => "1"
      response.should redirect_to(first_models_url)
    end
  end

end
