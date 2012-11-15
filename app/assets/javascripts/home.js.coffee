$ ->
  width = $('.imageContainer').width()
  newWidth = width / 3
  newHeight = newWidth * 0.56

  $('.crop').width(newWidth)
  $('.crop img').width(newWidth)
  $('.crop').height(newHeight)

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