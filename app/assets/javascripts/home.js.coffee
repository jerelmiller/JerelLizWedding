$ ->
  setMenuLinks()
  setIndicatorWidth()


setMenuLinks = =>
  $('.menu a').click (e) ->
    e.preventDefault()
    href = $(@).attr('href')
    $('html,body').stop().animate({
      scrollTop: $(href).offset().top - 70
    }, 1000, 'easeInOutExpo')

setIndicatorWidth = =>
  $indicators = $('.carousel-indicators li')
  indicators = $indicators.length

  if indicators > 0
    left_position = $($indicators[0]).offset().left
    right_position = $($indicators[indicators - 1]).offset().left + 20

    $('.carousel-indicators').width(right_position - left_position)