class TagSystemController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

  
  def index

    @tags = Item.tag_counts_on(:tags)
    
    @sites4 = ["http://feeds2.feedburner.com/slashfilm", "http://feeds.feedburner.com/totalfilm/news","http://moviesblog.mtv.com/feed", "http://www.mtv.com/rss/news/movies_full.jhtml", "http://www.iwatchstuff.com/index.xml", "http://feeds.movieweb.com/movieweb_movienews", "http://imgur.com/r/movies", "http://feeds.feedburner.com/thr/film", "http://rss.firstshowing.net/firstshowing", "http://www.guardian.co.uk/film/filmblog/rss", "http://www.guardian.co.uk/film/rss","http://www.telegraph.co.uk/culture/film/rss", "http://www.fandango.com/rss/moviefeed", "http://latino-review.com/feed/", "http://imgur.com/r/movies/rss","http://www.joblo.com/newsfeeds/rss.xml", "http://geektyrant.com/news/rss.xml", "http://blastr.com/atom.xml", "http://www.iamrogue.com/news?format=feed", "http://www.denofgeek.com/feeds/all", "http://www.cinemablend.com/rss-all.xml"]

    @title = ["http://feeds2.feedburner.com/slashfilm"]

    @img_link = []
    xml_doc  = Nokogiri::XML(open("http://feeds2.feedburner.com/slashfilm"))

    @testing1 = "Warner Bros. Will Open Baz Luhrmanns The Great Gatsby in May, Which Is Now Early Summer"

    @items = xml_doc.xpath("//item")

      @items.each do |item|

      # @testing = item.to_html.scan(/http[^<>]*jpg/).last.gsub('"',' ').gsub(' ',',').split(",").select{|s|s.match(/http[^<>]*jpg/)}.uniq
      # @testing1 = item.to_html.scan(/http[^<>]*jpg/).first
      # @testing1 = item.to_html.scan(/http[^"]*jpg/)
       #.gsub('"',' ').match(/http[^<>]*?jpg/)[0]

       @testing1.gsub(/([\:\/()'?".!])/, '')

    #  @img_link.push(item.to_html.scan(/http[^"]*jpg/).reject{|s|s.match(/http:\/\/media.movieweb.com\/i\/img\/feed\/fb.jpg/)}.reject{|t|t.include?('-70x53')}.reject{|k|k.include?('-550x')}.reject{|s|s.include?('--003')}.reject{|j|j.include?('-005')}.uniq)
      
   #  @test2 =  item.xpath("title").inner_text.to_s.split(/(?=[A-Z])/).join(' ').gsub(' ',',').gsub(',,',',').gsub(/([\:\/()'"!-])/, '')

     @title = item.xpath("title").inner_text.to_s.strip

       # @img_link.push(item.to_html.scan(/http[^<>]*jpg/).gsub('"','').match(/http[^<>]*jpg/)[0].gsub('mce_src=',','))

       # img_link.reject{|t|t.match(/&/)}

      end
  end
  def tag_cloud
  end

end
