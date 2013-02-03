class Wedding.Views.ImageView extends Backbone.View
  template: JST["backbone/templates/images/image"]
  titleTemplate: JST['backbone/templates/images/image_title']

  attributes:
    class: 'crop'

  initialize: ->
    @listenTo @model, 'sync', @renderImage
    @appendTitle = _.once @appendTitle

    @model.fetch
      data: { styles: 'regular;large' }

    $(window).resize _.delay(@setSizes, 100)

  render: =>
    @$el.html @template(@model.toJSON())
    @setSizes()
    @

  renderImage: (image) =>
    $img = @$('img.real')
    $img.attr('src', image.get('image_urls').regular)
    @$('a').attr('href', image.get('image_urls').large)
    @$el.hover @onHover, @onHoverOut
    $img.load =>
      @$el.spin(false)
      @$('img.placeholder').hide()
      $img.width @_imageWidth()
      $img.height @_imageHeight() if $img.height() < @_imageHeight()
      $img.fadeIn()

  onHover: =>
    @appendTitle()
    @$('img.real').fadeTo(150, 0.1)
    @$('.imageTitle').fadeIn(150)

  onHoverOut: =>
    @$('img.real').fadeTo(150, 1)
    @$('.imageTitle').hide(150)

  setSizes: =>
    @$el.width @_imageWidth()
    @$el.height @_imageHeight()
    @$('img.placeholder').width @_imageWidth()
    @$('img.placeholder').height @_imageHeight()

  appendTitle: =>
    @$el.append @titleTemplate(@model.toJSON())
    $imageTitle = @$('.imageTitle')
    $imageTitle.css 'top', (@_imageHeight() / 2) - ($imageTitle.height() / 2)
    $imageTitle.css 'left', (@_imageWidth() / 2) - ($imageTitle.width() / 2) - 10

  _imageWidth: =>
    width = $(window).width() - $('.sidebar').outerWidth()
    num_tiles = 4

    if width < 400 then width = 400
    if width < 470 then num_tiles = 1
    else if width < 870 then num_tiles = 2
    else if width < 1200 then num_tiles = 3

    width / num_tiles

  _imageHeight: =>
    @_imageWidth() * 0.56
      
