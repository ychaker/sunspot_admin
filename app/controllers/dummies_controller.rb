class DummiesController < ApplicationController
  # GET /dummies
  # GET /dummies.xml
  def index
    @dummies = Dummy.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @dummies }
    end
  end

  # GET /dummies/1
  # GET /dummies/1.xml
  def show
    @dummy = Dummy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dummy }
    end
  end

  # GET /dummies/new
  # GET /dummies/new.xml
  def new
    @dummy = Dummy.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @dummy }
    end
  end

  # GET /dummies/1/edit
  def edit
    @dummy = Dummy.find(params[:id])
  end

  # POST /dummies
  # POST /dummies.xml
  def create
    @dummy = Dummy.new(params[:dummy])

    respond_to do |format|
      if @dummy.save
        format.html { redirect_to(@dummy, :notice => 'Dummy was successfully created.') }
        format.xml  { render :xml => @dummy, :status => :created, :location => @dummy }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dummy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /dummies/1
  # PUT /dummies/1.xml
  def update
    @dummy = Dummy.find(params[:id])

    respond_to do |format|
      if @dummy.update_attributes(params[:dummy])
        format.html { redirect_to(@dummy, :notice => 'Dummy was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dummy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /dummies/1
  # DELETE /dummies/1.xml
  def destroy
    @dummy = Dummy.find(params[:id])
    @dummy.destroy

    respond_to do |format|
      format.html { redirect_to(dummies_url) }
      format.xml  { head :ok }
    end
  end
end
