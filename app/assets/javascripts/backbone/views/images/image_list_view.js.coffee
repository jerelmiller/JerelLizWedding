class Wedding.Views.ImageListView extends Backbone.View

  initialize: ->
    @listenTo @collection, 'reset', @addAll

  addAll: =>
    @collection.forEach @addOne, @

  addOne: (image) =>
    view = new Wedding.Views.ImageView
      model: image

    @$el.append view.render().el
    $(view.el).spin
      color: '#FFF'
      width: 4
      zIndex: 2000

  render: =>
    @addAll()
    @
