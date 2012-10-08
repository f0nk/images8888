class ItemsController < ApplicationController
  # GET /items
  # GET /items.json
  
   def index
    @search = Item.search(params[:q])
    @items = @search.result.order("created_at DESC").page(params[:page]).per_page(40)
    #@items = Item.order("created_at DESC").page(params[:page]).per_page(40)
    @tmp2 = Item.all

    @numberofrows = Item.count + Picture.count + (3*Item.count)


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
      format.js
    end
  end


  def tagged
      if params[:tag].present?
      @tmp = params[:tag]
      @items = Item.tagged_with(params[:tag]).order("created_at DESC").page(params[:page]).per_page(40)
      elsif params[:source].present? 
      @items = Item.tagged_with(params[:source]).order("created_at DESC").page(params[:page]).per_page(40)
      @tmp = params[:source]
    elsif params[:category].present? 
      @items = Item.tagged_with(params[:category]).order("created_at DESC").page(params[:page]).per_page(40)
      @tmp = params[:category]
    else 
      #@items = Item.postall.page(params[:page]).per_page(40)
      @items = Item.first
    end  
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  def tagcloud
  end

  def terms

  end

  def about
    @tagscount = []
    @tagscount = ActiveRecord::Base.connection.execute("SELECT COUNT (*) FROM tags").to_s
    @count = @tagscount[@tagscount.length-3].to_i

    @tagscount2 = []
    @tagscount2 = ActiveRecord::Base.connection.execute("SELECT COUNT (*) FROM taggings").to_s
    @count2 = @tagscount2[@tagscount2.length-3].to_i

    @numberofrows = Item.count + Picture.count + (3*Item.count)
    @numberofrows.to_f
    @threshold = 9990.to_f

    if @numberofrows > @threshold
        @items = Item.order("created_at ASC").limit(500)
          @items.each do |i|
            i.pictures.destroy_all
         end
        @items.destroy_all
    end
  end

end
