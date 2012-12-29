$ ->
  $imageContainer = $('body.admin .imageContainer')

  $imageContainer.find('.cropSmall').hover ->
    $(@).css('z-index', 9999)
    imgHeight = $(@).find('img')
  , ->
    $(@).css('overflow', 'hidden')