class Wedding.Views.MapsView extends Backbone.View

  template: JST["backbone/templates/maps/maps_template"]

  events:
    'click .directions' : 'showDirectionsContainer'
    'click .close'      : 'close'
    'click .submit'     : 'getDirections'

  initialize: =>
    @_setupMap()
    @searchByAddress @model.get('address')

  render: =>
    @$('.mapControls').html @template
    @

  renderDirections: (directions) =>
    @directionsDisplay.setDirections directions

  renderDirectionsList: (directions) =>
    @$('.directionsList').empty()
    _.each directions.routes[0].legs[0].steps, (step, stepNum) =>
      @appendStep step, parseInt(stepNum) + 1

    @_toggleDirectionsList true

  appendStep: (step, stepNum) =>
    @$('.directionsList').append "#{stepNum}: #{step.instructions}<br/>"

  showDirectionsContainer: =>
    @model.set 'hasMoved', false
    @$('.directionsContainer').slideDown
      easing: 'swing'
      always: =>
        @$('.directions').fadeTo 400, 0

  close: =>
    @_toggleDirectionsList false
    if @model.get('hasMoved')
      @$('.map, .directionsContainer').css({ right: '180px' }).animate right: '0',
        always: @hideDirectionsContainer
    else
      @hideDirectionsContainer()

  hideDirectionsContainer: =>
    @$('.directionsContainer').slideUp
      always: =>
        @$('.directions').fadeTo 400, 1

  getDirections: =>
    @setOrigin()
    @directionsService.route @model.directionsParams(), @handleDirections

  searchByAddress: (address) =>
    @geocoder.geocode
      address: address
    , @handleGeocode

  addMarker: (position) =>
    new google.maps.Marker
      map: @map
      position: position

  handleDirections: (result, status) =>
    if status == google.maps.DirectionsStatus.OK
      if @model.get 'hasMoved'
        @renderDirections result
        @renderDirectionsList result
      else
        @$('.map, .directionsContainer').animate right: '200px',
          always: =>
            @model.set 'hasMoved', true
            @renderDirections result
            @renderDirectionsList result
    else
      console.log 'Directions not successful'

  handleGeocode: (results, status) =>
    if status == google.maps.GeocoderStatus.OK
      @map.setCenter results[0].geometry.location
      @addMarker results[0].geometry.location
    else
      console.log 'Geocode not successful'

  setOrigin: =>
    @model.set 'origin', @$('input').val()

  _setupMap: =>
    @map = new google.maps.Map document.getElementById(@$('.map').attr('id')), @model.mapOptions()
    @_initializeServicesAndAddMap @map

  _initializeServicesAndAddMap: (map) =>
    @geocoder = new google.maps.Geocoder()
    @directionsService = new google.maps.DirectionsService()
    @directionsDisplay = new google.maps.DirectionsRenderer()
    @directionsDisplay.setMap map

  _toggleDirectionsList: (toggle) =>
    if toggle
      @$('.arrow.white').show()
      @$('.arrow.gray').fadeIn()
      @$('.directionsListContainer').fadeIn()
    else
      @$('.arrow').fadeOut()
      @$('.arrows, .directionsListContainer').fadeOut()
