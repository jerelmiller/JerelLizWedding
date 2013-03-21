class Wedding.Models.RSVP extends Backbone.Model

  url: '/rsvp'

  defaults:
    name: ''
    attending: 0

  validate: (attrs, options) =>
    errors = { name: [], attending: [] }
    errors.name.push "Name can't be empty" if _.isEmpty attrs.name
    errors.name.push "Name must be longer than 2 characters" if @get('name').length < 2
    errors.attending.push "# Attending can't be empty" if _.isEmpty attrs.attending
    errors.attending.push '# Attending must be numeric' if isNaN(parseFloat(@get('attending'))) || !isFinite(@get('attending'))
    errors unless _.isEmpty(errors.name) && _.isEmpty(errors.attending)