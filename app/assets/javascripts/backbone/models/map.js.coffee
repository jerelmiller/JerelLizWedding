class Wedding.Models.Map extends Backbone.Model

  # directionsBaseUrl: 'http://maps.googleapis.com/maps/api/directions/json?sensor=false'

  defaults:
    address: ''
    origin: ''
    latitude: 0
    longitude: 0

  # urlRoot: 'http://maps.googleapis.com/maps/api/directions/json?sensor=false'

  initialize: (options = {}) =>
    @set 'address', options.address
    @set 'latitude', options.latitude
    @set 'longitude', options.longitude

    # @_setupDirectionsService

  # fetchDirections: (from, to) =>
  #   @fetch
  #     data:
  #       origin: from
  #       destination: to
  directionsParams: =>
    _.extend {},
      origin: @get('origin')
      destination: @get('address')
      travelMode: google.maps.TravelMode.DRIVING

  mapOptions: =>
    _.extend {},
      center: new google.maps.LatLng @get('latitude'), @get('longitude')
      zoom: 15
      mapTypeId: google.maps.MapTypeId.ROADMAP
      mapTypeControl: false

  # _setupDirectionsService: =>
  #   @directionsService = new google.maps.DirectionsService()