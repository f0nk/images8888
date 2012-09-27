class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :taglist
  before_filter :sourcelist
  before_filter :categorylist
  before_filter :searchresult
  
  def taglist
    @taglist = Item.tag_counts_on(:tags)
  end

   def sourcelist
    @sourcelist = Item.tag_counts_on(:sources)
  end
   
   def categorylist
    @categorylist = Item.tag_counts_on(:categorys)
  end

   def searchresult
     @search = Item.search(params[:q])
  end
end
