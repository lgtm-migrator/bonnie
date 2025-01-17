# Input view for Any types in composite views
class Thorax.Views.InputAnyView extends Thorax.Views.BonnieView
  template: JST['patient_builder/inputs/any']

  # Expected options to be passed in using the constructor options hash:
  #   attributeName - The name of the attribute. Required
  #   cqmValueSets - List of CQM Value sets. Required.
  #   codeSystemMap - Map of code system oids to code system names. Required.
  #   defaultYear - Default year to use for Date/DateTime input views.
  initialize: ->
    @value = null

    @types = ['Code', 'Quantity', 'DateTime', 'Ratio', 'Integer', 'Decimal', 'Time']
    @currentType = ''

  events:
    'change select[name="type"]': 'handleTypeChange'
    rendered: ->
      if @currentType == ''
        @$('select[name="type"] > option:first').prop('selected', true)
      else
        @$("select[name=\"type\"] > option[value=\"#{@currentType}\"]").prop('selected', true)

  # checks if the value in this view is valid. returns true or false. this is used by the attribute entry view to determine
  # if the add button should be active or not
  hasValidValue: ->
    @value?

  # Event listener for select change event on the main select box for chosing custom or from valueset code
  handleTypeChange: (e) ->
    type = @$('select[name="type"]').val()

    if type != ''
      @inputView?.remove()
      @inputView = @_createInputViewForType(type, @attributeName)
      @value = @inputView.value
      @listenTo(@inputView, 'valueChanged', @handleInputUpdate)
      @trigger 'valueChanged', @
    else
      @value = null
      @inputView?.remove()
      @inputView = null
      @trigger 'valueChanged', @

    @currentType = type
    @render()

  handleInputUpdate: ->
    if @inputView.hasValidValue()
      @value = @inputView.value
    else
      @value = null
    @trigger 'valueChanged', @

  _createInputViewForType: (type, placeholderText) ->
    return switch type
      when 'Code' then new Thorax.Views.InputCodeView({ cqmValueSets: @cqmValueSets, codeSystemMap: @codeSystemMap })
      when 'Date' then new Thorax.Views.InputDateView({ allowNull: false, defaultYear: @defaultYear })
      when 'DateTime' then new Thorax.Views.InputDateTimeView({ allowNull: false, defaultYear: @defaultYear })
      when 'Decimal' then new Thorax.Views.InputDecimalView({ allowNull: false, placeholder: placeholderText })
      when 'Integer', 'Number' then new Thorax.Views.InputIntegerView({ allowNull: false, placeholder: placeholderText })
      when 'Quantity' then new Thorax.Views.InputQuantityView()
      when 'Ratio' then new Thorax.Views.InputRatioView()
      when 'Time' then new Thorax.Views.InputTimeView({ allowNull: false })
      else null
