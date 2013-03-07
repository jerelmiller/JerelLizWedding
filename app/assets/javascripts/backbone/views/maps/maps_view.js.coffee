class Wedding.Views.MapsView extends Backbone.View

  initialize: =>
    @_setupMap()

  render: =>
    @searchByAddress @model.get('address')
    @

  searchByAddress: (address) =>
    @geocoder.geocode
      address: address
    , @handleGeocode

  addMarker: (position) =>
    new google.maps.Marker
      map: @map
      position: position

  handleGeocode: (results, status) =>
    if status == google.maps.GeocoderStatus.OK
      @map.setCenter results[0].geometry.location
      @addMarker results[0].geometry.location
    else
      console.log 'Geocode not successful'


  _setupMap: =>
    @geocoder = new google.maps.Geocoder()
    @map = new google.maps.Map document.getElementById(@$el.attr('id')), @model.mapOptions()
