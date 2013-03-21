class Wedding.Views.Menu extends Backbone.View

  successTemplate: JST['backbone/templates/alerts/success']
  errorTemplate: JST['backbone/templates/alerts/error']

  events:
    'click a:not(#rsvp)' : 'animateToSection'
    'click #rsvp'        : 'showRSVP'
    'click .closeRSVP'   : 'hideRSVP'
    'click a'            : 'preventDefault'
    submit               : 'submitForm'

  initialize: =>
    @listenTo @model, 'invalid', @renderError
    @listenTo @model, 'error', @alertError
    @listenTo @model, 'sync', @renderSuccess
    @originalText = @$('input[type=submit]').val()

  animateToSection: (e) =>
    href = @$(e.target).attr('href')
    $('html,body').stop().animate
      scrollTop: $(href).offset().top - 70
    , 1000, 'easeInOutExpo'

  preventDefault: (e) =>
    e.preventDefault()

  showRSVP: =>
    @$('.rsvpContainer').slideDown()

  hideRSVP: =>
    @removeError()
    @clearFields()
    @$('.rsvpContainer').slideUp()

  submitForm: (e) =>
    e.preventDefault()
    @_setSubmitText 'Submitting...'
    @model.set @_formData()
    @model.save()

  renderError: (model, errors) =>
    @removeError()
    _.delay =>
      unless _.isEmpty errors.name
        @$('[name=name]').addClass('error')
        @renderErrorTooltip '[name=name]', errors.name.join('. ')
      unless _.isEmpty errors.attending
        @$('[name=attending]').addClass('error')
        @renderErrorTooltip '[name=attending]', errors.attending.join('. ')
    , 500

  renderSuccess: =>
    @removeError()
    @clearFields()
    @$('.alertMessage').html @successTemplate(text: 'Thank you for your RSVP!')
    _.delay =>
      @$('.alert').hide().slideDown()
    , 500

    _.delay =>
      @$('.alert').animate opacity: 0,
        duration: 100
        always: =>
          @$('.alert').slideUp
            done: =>
              @$('.alert').alert('close')
    , 3000

  alertError: =>
    @removeError()
    @$('.alertMessage').html @errorTemplate(text: 'There was an error processing your request. Please try again.')
    _.delay =>
      @$('.alert').hide().slideDown()
    , 500

  removeError: =>
    _.delay =>
      @_setSubmitText @originalText
    , 500
    @$('input').removeClass('error')
    @$('input').tooltip 'destroy'
    @$('.alert').alert('close')

  clearFields: =>
    _.delay =>
      @$('input[type=text]').val ''
    , 500

  renderErrorTooltip: (input, text) =>
    @$(input).tooltip
      title: text
      trigger: 'manual'
      placement: 'bottom'

    @$(input).tooltip('show')

  _setSubmitText: (text) =>
    @$('input[type=submit]').val text

  _formData: =>
    form = @$('form').serializeArray()

    _.reduce form, (data, field) =>
      data[field.name] = field.value
      data
    , {}