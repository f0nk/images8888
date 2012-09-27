class WelcomeController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

  def index
 
    @tmp = Item.order("created_at DESC")
    @tmp2 = Picture.all

  end

  def scrape
    @sites = ["http://feeds2.feedburner.com/slashfilm", "http://feeds.feedburner.com/totalfilm/news", "http://feeds.ign.com/ign/movies-all","http://moviesblog.mtv.com/feed", "http://www.mtv.com/rss/news/movies_full.jhtml", "http://www.iwatchstuff.com/index.xml", "http://feeds.movieweb.com/movieweb_movienews", "http://imgur.com/r/movies", "http://feeds.feedburner.com/Cinecast", "http://feeds.feedburner.com/thr/film", "http://rss.firstshowing.net/firstshowing"]

    @sites2 = ["http://feeds2.feedburner.com/slashfilm", "http://feeds.feedburner.com/totalfilm/news","http://moviesblog.mtv.com/feed", "http://www.mtv.com/rss/news/movies_full.jhtml", "http://www.iwatchstuff.com/index.xml", "http://feeds.movieweb.com/movieweb_movienews", "http://imgur.com/r/movies", "http://feeds.feedburner.com/thr/film", "http://rss.firstshowing.net/firstshowing"]

    @sites3 = ["http://feeds2.feedburner.com/slashfilm", "http://feeds.feedburner.com/totalfilm/news","http://moviesblog.mtv.com/feed", "http://www.mtv.com/rss/news/movies_full.jhtml", "http://www.iwatchstuff.com/index.xml", "http://feeds.movieweb.com/movieweb_movienews", "http://imgur.com/r/movies", "http://feeds.feedburner.com/thr/film", "http://rss.firstshowing.net/firstshowing", "http://www.guardian.co.uk/film/filmblog/rss", "http://www.guardian.co.uk/film/rss","http://www.telegraph.co.uk/culture/film/rss", "http://www.fandango.com/rss/moviefeed", "http://latino-review.com/feed/", "http://imgur.com/r/movies/rss","http://www.joblo.com/newsfeeds/rss.xml", "http://geektyrant.com/news/rss.xml", "http://blastr.com/atom.xml", "http://www.iamrogue.com/news?format=feed", "http://www.denofgeek.com/feeds/all", "http://www.cinemablend.com/rss-all.xml"]

    #"http://www.iamrogue.com/news?format=feed"
    #, "http://blastr.com/atom.xml"
    # "http://feeds.feedburner.com/totalfilm/news"
    #http://imgur.com/r/movies/rss

        #@categories = ["All, Geek, News, Buzz, Fun, Top Hits"]


    @newssites = ["http://feeds2.feedburner.com/slashfilm", "http://www.iwatchstuff.com/index.xml", "http://feeds.movieweb.com/movieweb_movienews?format=xml", "http://feeds.feedburner.com/thr/film", "http://rss.firstshowing.net/firstshowing", "http://www.guardian.co.uk/film/filmblog/rss", "http://www.guardian.co.uk/film/rss","http://www.telegraph.co.uk/culture/film/rss", "http://www.fandango.com/rss/moviefeed", "http://latino-review.com/feed/", "http://www.joblo.com/newsfeeds/rss.xml", "http://www.cinemablend.com/rss-all.xml", "http://feeds.feedburner.com/totalfilm/news","http://www.iamrogue.com/news?format=feed", "http://feeds.feedburner.com/FilmSchoolRejects?format=xml", "http://feeds.feedburner.com/Pajiba"]


    @geeksites =["http://www.denofgeek.com/feeds/all", "http://geektyrant.com/news/rss.xml"]

    @funsites = ["http://imgur.com/r/movies/rss"]

    @buzzsites = ["http://moviesblog.mtv.com/feed", "http://www.mtv.com/rss/news/movies_full.jhtml",]

    @random = ["http://feeds2.feedburner.com/slashfilm", "http://www.denofgeek.com/feeds/all"]

   scraping(@newssites, "News")
   scraping(@geeksites, "Geek")
   scraping(@funsites, "Fun")
   scraping(@buzzsites, "Buzz")

   #scraping(@random, "Random")

  end


  def scraping(sitecollection, categ)

    sitecollection.each do |site|
      xml_doc  = Nokogiri::XML(open(site))
    
      @items = xml_doc.xpath("//item")

      if xml_doc.xpath("//title").first == nil
        @source = site
      else
        @source = xml_doc.xpath("//title").first.inner_text.to_s
      end

      @items.each do |item|

        img_link =  item.to_html.scan(/http[^"]*jpg/).reject{|s|s.match(/http:\/\/media.movieweb.com\/i\/img\/feed\/fb.jpg/)}.reject{|t|t.include?('-70x53')}.reject{|k|k.include?('-550x')}.reject{|s|s.include?('--003')}.reject{|j|j.include?('-005')}.reject{|j|j.include?('tops')}.reject{|j|j.include?('-003.')}.reject{|j|j.include?('b.jpg')}.reject{|j|j.include?('h.jpg')}.uniq

        title = item.xpath("title").inner_text.to_s.strip

        break if Picture.where(:url => img_link).exists? == true || Item.where(:title => title).exists? == true

          i = Item.new
          i.title = title
          #i.keywords = item.xpath("category").inner_text.to_s.gsub( / /, "," )
          i.article_url = item.xpath("link").inner_text.to_s.strip
          i.source_list = @source.strip
          i.category_list = categ + ", All"
          i.tag_list = title.gsub(' ',', ').gsub('-',' ').gsub(/([\:\/()'?".!-])/, '') + ',' + item.xpath("category").inner_text.to_s.split(/(?=[A-Z])/).join(' ').gsub(' ',',').gsub(',,',',').gsub(/([\:\/()'?".!-])/, '')
          i.save

          img_link.each do |p|
            pic = Picture.new
            pic.url = p
            i.pictures << pic
          end      
        end
      end
  end


end
