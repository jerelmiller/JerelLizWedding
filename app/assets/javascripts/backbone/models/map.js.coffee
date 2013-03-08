class Wedding.Models.Map extends Backbone.Model

  defaults:
    address: ''
    latitude: 0
    longitude: 0

  initialize: (options = {}) =>
    @set 'address', options.address
    @set 'latitude', options.latitude
    @set 'longitude', options.longitude

  mapOptions: =>
    _.extend {},
      center: new google.maps.LatLng @get('latitude'), @get('longitude')
      zoom: 15
      mapTypeId: google.maps.MapTypeId.ROADMAP