class Wedding.Models.Map extends Backbone.Model

  defaults:
    address: ''
    origin: ''
    latitude: 0
    longitude: 0

  initialize: (options = {}) =>
    @set 'address', options.address
    @set 'latitude', options.latitude
    @set 'longitude', options.longitude
    @_setup()

  initializeDestination: (callback) =>
    @geocoder.geocode
      address: @get('address')
    , (results, status) =>
      return callback(results) if status == google.maps.GeocoderStatus.OK
      console.log 'Geocode not successful'

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

  getDirections: (callback) =>
    @directionsService.route @directionsParams(), (result, status) =>
      return callback(result) if status == google.maps.DirectionsStatus.OK
      console.log 'Directions not successful'

  _setup: =>
    @geocoder = new google.maps.Geocoder()
    @directionsService = new google.maps.DirectionsService()