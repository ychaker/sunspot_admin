class FirstModelsController < ApplicationController
  # GET /first_models
  # GET /first_models.xml
  def index
    @first_models = FirstModel.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @first_models }
    end
  end

  # GET /first_models/1
  # GET /first_models/1.xml
  def show
    @first_model = FirstModel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @first_model }
    end
  end

  # GET /first_models/new
  # GET /first_models/new.xml
  def new
    @first_model = FirstModel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @first_model }
    end
  end

  # GET /first_models/1/edit
  def edit
    @first_model = FirstModel.find(params[:id])
  end

  # POST /first_models
  # POST /first_models.xml
  def create
    @first_model = FirstModel.new(params[:first_model])

    respond_to do |format|
      if @first_model.save
        format.html { redirect_to(@first_model, :notice => 'First model was successfully created.') }
        format.xml  { render :xml => @first_model, :status => :created, :location => @first_model }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @first_model.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /first_models/1
  # PUT /first_models/1.xml
  def update
    @first_model = FirstModel.find(params[:id])

    respond_to do |format|
      if @first_model.update_attributes(params[:first_model])
        format.html { redirect_to(@first_model, :notice => 'First model was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @first_model.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /first_models/1
  # DELETE /first_models/1.xml
  def destroy
    @first_model = FirstModel.find(params[:id])
    @first_model.destroy

    respond_to do |format|
      format.html { redirect_to(first_models_url) }
      format.xml  { head :ok }
    end
  end
end
