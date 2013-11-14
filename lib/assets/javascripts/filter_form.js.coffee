class PredicateSelector
  _select: null

  _predicates: [
    { name: '=', value: 'eq' },
    { name: '>', value: 'gt' },
    { name: '<', value: 'lt' }
  ]

  @element_for_attribute: ->
    { name: 'with', value: 'predicate_selector' }

  @class_name: ->
    'predicate_selector'

  constructor: (@element) ->
    @insert_selector()
    @set_onchange_listener()

  insert_selector: ->
    @_select = $("<select for='#{ $(@element).attr('id') }' class='#{ @constructor.class_name() }'><select>")
    for predicate in @_predicates
      $(@_select).append("<option value='#{ predicate.name }'>#{ predicate.name }</option>")
    $(@_select).insertBefore(@element)

  set_onchange_listener: ->
    $(@_select).change ->
      console.log @

###############################################################################

$ ->
  $('.filter_form_select2').select2()

  $('.filter_form_date').datepicker
    dateFormat: 'yy-mm-dd'

  for element in $("[#{ PredicateSelector.element_for_attribute().name }='#{ PredicateSelector.element_for_attribute().value }']")
    new PredicateSelector(element)
