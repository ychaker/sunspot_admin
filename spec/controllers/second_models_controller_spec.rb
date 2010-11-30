require 'spec_helper'

describe SecondModelsController do

  def mock_second_model(stubs={})
    (@mock_second_model ||= mock_model(SecondModel).as_null_object).tap do |second_model|
      second_model.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all second_models as @second_models" do
      SecondModel.stub(:all) { [mock_second_model] }
      get :index
      assigns(:second_models).should eq([mock_second_model])
    end
  end

  describe "GET show" do
    it "assigns the requested second_model as @second_model" do
      SecondModel.stub(:find).with("37") { mock_second_model }
      get :show, :id => "37"
      assigns(:second_model).should be(mock_second_model)
    end
  end

  describe "GET new" do
    it "assigns a new second_model as @second_model" do
      SecondModel.stub(:new) { mock_second_model }
      get :new
      assigns(:second_model).should be(mock_second_model)
    end
  end

  describe "GET edit" do
    it "assigns the requested second_model as @second_model" do
      SecondModel.stub(:find).with("37") { mock_second_model }
      get :edit, :id => "37"
      assigns(:second_model).should be(mock_second_model)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created second_model as @second_model" do
        SecondModel.stub(:new).with({'these' => 'params'}) { mock_second_model(:save => true) }
        post :create, :second_model => {'these' => 'params'}
        assigns(:second_model).should be(mock_second_model)
      end

      it "redirects to the created second_model" do
        SecondModel.stub(:new) { mock_second_model(:save => true) }
        post :create, :second_model => {}
        response.should redirect_to(second_model_url(mock_second_model))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved second_model as @second_model" do
        SecondModel.stub(:new).with({'these' => 'params'}) { mock_second_model(:save => false) }
        post :create, :second_model => {'these' => 'params'}
        assigns(:second_model).should be(mock_second_model)
      end

      it "re-renders the 'new' template" do
        SecondModel.stub(:new) { mock_second_model(:save => false) }
        post :create, :second_model => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested second_model" do
        SecondModel.should_receive(:find).with("37") { mock_second_model }
        mock_second_model.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :second_model => {'these' => 'params'}
      end

      it "assigns the requested second_model as @second_model" do
        SecondModel.stub(:find) { mock_second_model(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:second_model).should be(mock_second_model)
      end

      it "redirects to the second_model" do
        SecondModel.stub(:find) { mock_second_model(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(second_model_url(mock_second_model))
      end
    end

    describe "with invalid params" do
      it "assigns the second_model as @second_model" do
        SecondModel.stub(:find) { mock_second_model(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:second_model).should be(mock_second_model)
      end

      it "re-renders the 'edit' template" do
        SecondModel.stub(:find) { mock_second_model(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested second_model" do
      SecondModel.should_receive(:find).with("37") { mock_second_model }
      mock_second_model.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the second_models list" do
      SecondModel.stub(:find) { mock_second_model }
      delete :destroy, :id => "1"
      response.should redirect_to(second_models_url)
    end
  end

end
