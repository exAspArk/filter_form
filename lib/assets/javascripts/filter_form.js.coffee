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
    @set_current_predicate()

  insert_selector: ->
    @_select = $("<select for='#{ $(@element).attr('id') }' class='#{ @constructor.class_name() }'><select>")
    for predicate in @_predicates
      $(@_select).append("<option value='#{ predicate.name }'>#{ predicate.name }</option>")
    $(@_select).insertBefore(@element)

  set_onchange_listener: ->
    self = @
    $(@_select).change ->
      predicate = self.find_predicate_by_name $(@).val()
      self.set_name_to_element(predicate)

  set_name_to_element: (predicate) ->
    new_name = "q[#{ $(@element).attr('id').replace('q_', '') }_#{ predicate.value }]"
    $(@element).attr('name', new_name)

  find_predicate_by_name: (name) ->
    for predicate in @_predicates
      return predicate if predicate.name is name

  set_current_predicate: ->
    if @current_predicate()
      $(@_select).val(@current_predicate().name).change()

  current_predicate: ->
    for predicate in @_predicates
      return predicate if predicate.value is $(@element).data('current-predicate')

###############################################################################

$ ->
  for element in $("[data-#{ PredicateSelector.element_for_attribute().name }='#{ PredicateSelector.element_for_attribute().value }']")
    new PredicateSelector(element)

  $('.filter_form_select2').select2()

  $('.filter_form_date').datepicker
    dateFormat: 'yy-mm-dd'
