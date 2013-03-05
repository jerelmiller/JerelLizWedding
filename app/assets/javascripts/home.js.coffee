$ ->
  setMenuLinks()
  setIndicatorWidth()


setMenuLinks = =>
  $('.menu a').click (e) ->
    e.preventDefault()
    href = $(@).attr('href')
    $('html,body').stop().animate({
      scrollTop: $(href).offset().top - 65
    }, 1000, 'easeInOutExpo')

setIndicatorWidth = =>
  $indicators = $('.carousel-indicators li')
  indicators = $indicators.length

  if indicators > 0
    left_position = $($indicators[0]).offset().left
    right_position = $($indicators[indicators - 1]).offset().left + 20

    $('.carousel-indicators').width(right_position - left_position)


    # $('ul.nav a').bind('click',function(event){
    #           var $anchor = $(this);

    #           $('html, body').stop().animate({
    #               scrollTop: $($anchor.attr('href')).offset().top
    #           }, 1500,'easeInOutExpo');
    #           $('html, body').stop().animate({
    #               scrollTop: $($anchor.attr('href')).offset().top
    #           }, 1000);
    #           event.preventDefault();
    #       });

#   # $(window).resize ->

#   #   if this.resizeTO
#   #     clearTimeout(this.resizeTO)

#   #   this.resizeTO = setTimeout ->
#   #     width = $(window).width() - $('.sidebar').outerWidth()
#   #     num_tiles = 4

#   #     if width < 400
#   #       width = 400

#   #     if width < 470
#   #       num_tiles = 1
#   #     else if width < 870
#   #       num_tiles = 2
#   #     else if width < 1200
#   #       num_tiles = 3

#   #     newWidth = width / num_tiles
#   #     newHeight = newWidth * 0.56

#   #     # Animate the resize
#   #     $('.crop').animate
#   #       width: newWidth
#   #       height: newHeight
#   #     , 100

#   #     $('.crop img').animate
#   #       width: newWidth
#   #     , 100

#   #     $('body:not(.admin) .imageContainer').animate
#   #       width: width
#   #     , 100
#   #   , 400