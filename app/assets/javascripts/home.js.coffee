$ ->
  setIndicatorWidth()
  calculateHeaderImageSize()
  $(window).resize calculateHeaderImageSize

setIndicatorWidth = =>
  $indicators = $('.carousel-indicators li')
  indicators = $indicators.length

  if indicators > 0
    left_position = $($indicators[0]).offset().left
    right_position = $($indicators[indicators - 1]).offset().left + 20

    $('.carousel-indicators').width(right_position - left_position)

calculateHeaderImageSize = =>
  windowWidth = $(window).width()
  newWidth = -((800 - windowWidth) / 2)
  if windowWidth < 470
    $('#home').css('left', newWidth - 20 + 'px')

  else if windowWidth < 800
    $('#home').css('left', newWidth + 'px');

  if windowWidth == 320
    $('#home').css('left', -170 + 'px')


  if windowWidth > 800
    $('#home').removeAttr('style')
