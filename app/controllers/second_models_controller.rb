class SecondModelsController < ApplicationController
  # GET /second_models
  # GET /second_models.xml
  def index
    @second_models = SecondModel.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @second_models }
    end
  end

  # GET /second_models/1
  # GET /second_models/1.xml
  def show
    @second_model = SecondModel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @second_model }
    end
  end

  # GET /second_models/new
  # GET /second_models/new.xml
  def new
    @second_model = SecondModel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @second_model }
    end
  end

  # GET /second_models/1/edit
  def edit
    @second_model = SecondModel.find(params[:id])
  end

  # POST /second_models
  # POST /second_models.xml
  def create
    @second_model = SecondModel.new(params[:second_model])

    respond_to do |format|
      if @second_model.save
        format.html { redirect_to(@second_model, :notice => 'Second model was successfully created.') }
        format.xml  { render :xml => @second_model, :status => :created, :location => @second_model }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @second_model.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /second_models/1
  # PUT /second_models/1.xml
  def update
    @second_model = SecondModel.find(params[:id])

    respond_to do |format|
      if @second_model.update_attributes(params[:second_model])
        format.html { redirect_to(@second_model, :notice => 'Second model was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @second_model.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /second_models/1
  # DELETE /second_models/1.xml
  def destroy
    @second_model = SecondModel.find(params[:id])
    @second_model.destroy

    respond_to do |format|
      format.html { redirect_to(second_models_url) }
      format.xml  { head :ok }
    end
  end
end
