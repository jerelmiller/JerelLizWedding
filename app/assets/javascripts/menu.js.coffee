$ ->
  $('ul a').hover ->
    $this = $(this)
    # $this.parents('ul').animate({'margin-top': '-30px'}, 'slow')
    $this.animate({padding: '15px 0 15px 40px'}, 100).css('background', 'rgba(100, 100, 100, 0.6)')
    # $this.parents('ul').animate({marginTop: '38px'})
    # console.log($(this).parents('ul'))
    # $(this).css('margin', '20px 0')
  , ->
    $this = $(this)
    $this.animate({padding: '0 0 0 40px'}, 100).css('background', 'none')
    $this.parents('ul').animate({marginTop: '50px'})