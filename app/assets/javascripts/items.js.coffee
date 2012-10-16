# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $container = $('#items')
  $container.imagesLoaded ->
    $container.masonry({
      itemSelector : '.inneritem'
    })

  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').html('<div id="spinner"><img src="http://i.imgur.com/wJp2J.gif"/></div>')
        $.getScript(url)
    $(window).scroll()