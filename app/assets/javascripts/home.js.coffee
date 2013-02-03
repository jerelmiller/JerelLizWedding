# $ ->

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