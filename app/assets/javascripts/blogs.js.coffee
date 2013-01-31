$ ->
  $('.blogItem .body').each ->
    $(@).truncate
      max_length: 350

  $container = $('#blogsContainer')
  $container.imagesLoaded ->
    $container.isotope
      itemSelector: '.blogItem'
      layoutMode: 'masonry'

  $container.find('img:not(.coverPhoto)').css('height', '')