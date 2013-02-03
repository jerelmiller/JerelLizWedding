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
  $('body:not(.admin) .imageContainer').width(width)

  $('.crop img').each ->
    $(@).load ->
      if @.height < newHeight
        $(@).height(newHeight)

  $('.crop').hover ->
    $a = $(this).find('a')
    title = $a.data('title')
    href = $a.attr('href')

    $(this).find('img').fadeTo(150, 0.1)
    $(this).append("<a class='imageTitle' rel='lightbox[images]' href='#{href}' data-ignore-lightbox='true'>#{title}</a>")

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

    if this.resizeTO
      clearTimeout(this.resizeTO)

    this.resizeTO = setTimeout ->
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

      $('body:not(.admin) .imageContainer').animate
        width: width
      , 100
    , 400

  $(window).load ->
    $('.crop').spin
      color: '#CCC'
      width: 4
    $('.crop').each ->
      $this = $(this)
      $image = $(this).find('img')
      $link = $(this).find('a')

      $.ajax
        url: "/images/#{$image.data('id')}/url"
        data: { size: 'regular' }
        success: (data) =>
          $image.attr('src', data.image_url)
          $image.load ->
            $this.spin(false)
            $image.hide().fadeIn()

      $.ajax
        url: "/images/#{$image.data('id')}/url"
        data: { size: 'large' }
        success: (data) =>
          $link.attr('href', data.image_url)