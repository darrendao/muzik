class BlackListsController < ApplicationController
  # GET /black_lists
  # GET /black_lists.json
  def index
    @black_lists = BlackList.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @black_lists }
    end
  end

  # GET /black_lists/1
  # GET /black_lists/1.json
  def show
    @black_list = BlackList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @black_list }
    end
  end

  # GET /black_lists/new
  # GET /black_lists/new.json
  def new
    @black_list = BlackList.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @black_list }
    end
  end

  # GET /black_lists/1/edit
  def edit
    @black_list = BlackList.find(params[:id])
  end

  # POST /black_lists
  # POST /black_lists.json
  def create
    @black_list = BlackList.new(params[:black_list])

    respond_to do |format|
      if @black_list.save
        format.html { redirect_to @black_list, :notice => 'Black list was successfully created.' }
        format.js {
          if request.env["HTTP_REFERER"].include? "locations"
            @location = @black_list.location
            render "/locations/update_blacklisttable"
          end
        }
        format.json { render :json => @black_list, :status => :created, :location => @black_list }
      else
        format.html { render :action => "new" }
        format.json { render :json => @black_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /black_lists/1
  # PUT /black_lists/1.json
  def update
    @black_list = BlackList.find(params[:id])

    respond_to do |format|
      if @black_list.update_attributes(params[:black_list])
        format.html { redirect_to @black_list, :notice => 'Black list was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @black_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /black_lists/1
  # DELETE /black_lists/1.json
  def destroy
    @black_list = BlackList.find(params[:id])
    @black_list.destroy

    respond_to do |format|
      format.html { redirect_to black_lists_url }
      format.js {
        if request.env["HTTP_REFERER"].include? "locations"
          @location = @black_list.location
          render "/locations/update_blacklisttable"
        end
      }
      format.json { head :ok }
    end
  end
end
