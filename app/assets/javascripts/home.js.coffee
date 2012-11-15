$ ->
  width = $(window).width() - $('.sidebar').outerWidth()
  num_tiles = 4

  if width < 400
    width = 400

  if width < 470
    num_tiles = 1
  else if width < 870
    num_tiles = 2
  else if width < 1200
    num_tiles = 3

  newWidth = width / num_tiles
  newHeight = newWidth * 0.56

  $('.crop').width(newWidth)
  $('.crop').height(newHeight)
  $('.crop img').width(newWidth)
  # Ensure that resizing won't make the tiles arrange right away
  $('.imageContainer').css('width', width)

  $('.crop').hover ->
    title = $(this).find('a').data('title')
    href = $(this).find('a').prop('href')

    $(this).find('img').fadeTo(150, 0.1)
    $(this).append("<a class='imageTitle' href='#{href}'>#{title}</a>")

    $imageTitle = $(this).find('a.imageTitle')
    titleWidth = $imageTitle.width()
    titleHeight = $imageTitle.height()
    left = (newWidth / 2) - (titleWidth / 2) - 10
    top = (newHeight / 2) - (titleHeight / 2)

    $imageTitle.css('top', top).css('left', left).css('text-align', 'center')
  , ->
    $(this).find('img').fadeTo(150, 1)
    $('a.imageTitle').remove()

  $(window).resize ->

    setTimeout ->
      width = $(window).width() - $('.sidebar').outerWidth()
      num_tiles = 4

      if width < 400
        width = 400

      if width < 470
        num_tiles = 1
      else if width < 870
        num_tiles = 2
      else if width < 1200
        num_tiles = 3

      newWidth = width / num_tiles
      newHeight = newWidth * 0.56

      # Animate the resize
      $('.crop').animate
        width: newWidth
        height: newHeight
      , 100

      $('.crop img').animate
        width: newWidth
      , 100

      $('.imageContainer').animate
        width: width
      , 100

    , 700