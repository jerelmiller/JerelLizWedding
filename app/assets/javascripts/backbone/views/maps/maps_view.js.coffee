class Wedding.Views.MapsView extends Backbone.View

  template: JST["backbone/templates/maps/maps_template"]

  events:
    'click .directions' : 'showDirectionsContainer'
    'click .close'      : 'close'
    'click .submit'     : 'getDirections'

  initialize: =>
    @_setupMap()

  render: =>
    @$('.mapControls').html @template
    @

  renderDirections: (directions) =>
    @directionsDisplay.setDirections directions
    @renderDirectionsList directions

  renderDirectionsList: (directions) =>
    @$('.directionsList').empty()
    _.each directions.routes[0].legs[0].steps, (step, stepNum) =>
      @appendStep step, parseInt(stepNum) + 1

    @_toggleDirectionsList true

  appendStep: (step, stepNum) =>
    @$('.directionsList').append "#{stepNum}: #{step.instructions}<br/>"

  showDirectionsContainer: =>
    @model.set 'hasMoved', false
    @$('.directionsContainer').slideDown @_slideContainerOptions(0)

  hideDirectionsContainer: =>
    @$('.directionsContainer').slideUp @_slideContainerOptions(1)

  close: =>
    @_toggleDirectionsList false
    return @hideDirectionsContainer() unless @model.get('hasMoved')
    @$('.map, .directionsContainer').css({ right: '180px' }).animate right: '0',
      always: @hideDirectionsContainer

  getDirections: =>
    @model.set 'origin', @$('input').val()
    @model.getDirections @handleDirections

  addMarker: (position) =>
    new google.maps.Marker
      map: @map
      position: position

  handleDirections: (directions) =>
    return @renderDirections directions if @model.get('hasMoved')
    @$('.map, .directionsContainer').animate right: '200px',
      always: =>
        @model.set 'hasMoved', true
        @renderDirections directions

  setCenter: (results) =>
    @map.setCenter results[0].geometry.location
    @addMarker results[0].geometry.location

  _setupMap: =>
    @map = new google.maps.Map document.getElementById(@$('.map').attr('id')), @model.mapOptions()
    @directionsDisplay = new google.maps.DirectionsRenderer()
    @directionsDisplay.setMap @map
    @model.initializeDestination @setCenter

  _toggleDirectionsList: (toggle) =>
    if toggle
      @$('.arrow.white').show()
      @$('.arrow.gray').fadeIn()
      @$('.directionsListContainer').fadeIn()
    else
      @$('.arrow').fadeOut()
      @$('.arrows, .directionsListContainer').fadeOut()

  _slideContainerOptions: (opacity) =>
    _.extend {},
      easing: 'swing'
      always: =>
        @$('.directions').fadeTo 400, opacity
