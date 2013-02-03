$ ->
  $imageContainer = $('body.admin .imageContainer')

  originalHeight = 0

  $imageContainer.find('.cropSmall').hover ->
    $this = $(@)
    originalHeight = $this.height()
    width = $this.width()
    width = width + 20 unless $this.hasClass('first')

    $this.css('z-index', 9999)
    $this.addClass('hover')
    $this.after('<div class="filler"></div>')

    $('.filler').height(originalHeight)
      .width(width)
      .css('float', 'left')

    if $this.hasClass('last')
      $('.filler').css('margin-bottom', '20px')
      $('.content .container').width(1000).css('padding-left', '40px')

    # Add position so that the element stays put
    position = $this.position()
    $this.css('left', position.left - 20).css('top', position.top - 20)
    $this.css('position', 'absolute')
    authenticity_token = $('meta[name=csrf-token]').attr('content')

    $this.append(
      "<form action='/admin/images/#{$this.data('image-id')}' method='post'>" +
        '<input name="_method" type="hidden" value="put">' +
        '<input name="authenticity_token" type="hidden" value="' + authenticity_token + '">' +
        '<div class="caption">' + $this.data('caption') + '</div>' +
        "<textarea name='image[title]'>#{$this.data('caption')}</textarea>" +
      '</form>'
    )
    $this.append(
      '<span class="iconWrapper edit left pullLeft">' +
        '<i class="icon-pencil"></i>' +
      '</span>'
    )
    $this.append(
      '<span class="iconWrapper delete right pullRight">' +
        '<i class="icon-trash"></i>' +
      '</span>'
    )

    $('textarea').hide()

    $('.iconWrapper').hover ->
      $(@).find('i').addClass('icon-white')
    , ->
      $(@).find('i').removeClass('icon-white')

    $('.iconWrapper.edit').click ->
      captionText = $('.caption').text()
      $('.caption').hide()
      $('textarea').show()
      $('textarea').focus()
      $('textarea').keypress (e) ->
        if e.which == 13
          e.preventDefault()
          url = $this.find('form').attr('action')
          data = { image: { title: $this.find('form textarea').val() }}
          $.ajax
            url: url
            data: data
            dataType: 'json'
            type: 'put'
            success: (data) ->
              $this.data('caption', data.title)
              $this.find('textarea').hide()
              $('.caption').text(data.title).show()

      .blur ->
        url = $this.find('form').attr('action')
        data = { image: { title: $this.find('form').find('textarea').val() }}
        $.ajax
          url: url
          data: data
          dataType: 'json'
          type: 'put'
          success: (data) ->
            $this.data('caption', data.title)
            $this.find('textarea').hide()
            $('.caption').text(data.title).show()

    $('.iconWrapper.delete').click ->
      $form = $this.find('form')
      $this.addClass('disabled')
      if confirm('Are you sure you want to delete that photo?')
        $.ajax
          url: $form.attr('action')
          type: 'delete'
          success: (data) ->
            $this.nextAll('.last').each ->
              $(@).removeClass('last')
              $(@).next().addClass('last')
            $this.nextAll('.first').each ->
              $(@).removeClass('first')
              $(@).next().addClass('first')
            if $this.hasClass('first')
              $this.next().addClass('first')
            $this.fadeOut ->
              $this.remove()
              $('.filler').remove()


    imgHeight = $this.find('img').height()
    captionHeight = $this.find('.caption').outerHeight()
    pencilHeight = $this.find('.iconWrapper').outerHeight()
    $this.animate
      height: imgHeight + captionHeight + pencilHeight
    , 150, ->
      $this.css('height', 'auto')

  , ->
    $(@).animate
      height: originalHeight
    , 0

    $(@).removeClass('hover')
    $(@).removeAttr('style')
    $(@).next('.filler').remove()
    $(@).find('.caption, .icon-pencil, .icon-trash, form, .iconWrapper, textarea').remove()
    $('.content .container').removeAttr('style')