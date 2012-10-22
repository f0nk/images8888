# encoding: utf-8

class ItemsController < ApplicationController

  # GET /items
  # GET /items.json
   def index
    @search = Item.search(params[:q])
    
    @holder = @search.result.order("created_at DESC").limit(20)

    @items = @search.result.order("created_at DESC").page(params[:page]).per_page(20)
    #@items2 = @search.result.order("created_at DESC").page(params[:page]).per_page(1)


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
    @var = "Is 'Paranormal Activity 4' The Best Yet? Frightened Fans Weigh InNew ‘Wreck-It Ralph’ Clip'Star Trek Into Darkness' Teaser is NOT Being Unveiled on FacebookArnold Schwarzenegger's 'Total Recall' Book Debuts to Soft SalesLars von Trier Veterans Willem Dafoe, Udo Kier Complete 'Nymphomaniac' Cast ‘Paranorman’ and ‘Coraline’ Studio Laika Announces a 2014 Release  Seal Team Six: The Raid on Osama Bin Laden 'Geronimo' Clip + ‘Hungry Hungry Hippos: The Movie’ Is Really Happening"

    #@test =  @var.match(/'[^']*'/)
     @test = Array.new
     @test = @var.scan(/‘[^’]*’| '[^']*'/)
      @test.each do |s|
        s.strip!
        s[0] = ''
        s.chop!
      end

      # setup your API key
      Tmdb.api_key = ""

      # setup your default language
      Tmdb.default_language = "en"

      @movie = TmdbMovie.find(:title => "Iron Man", :expand_results => false, :limit => 1)

      

  end

  def about
     @search = Item.search(params[:q])
    @items = @search.result.order("created_at DESC").page(params[:page]).per_page(20)
    #@items = Item.order("created_at DESC").page(params[:page]).per_page(40)
    @tmp2 = Item.all


  end

end
