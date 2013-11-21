class PredicateSelector
  @CLASS_NAME: 'predicate_selector'

  _select: null

  _predicates: ->
    JSON.parse($(@element).attr(@constructor.element_for_attribute()))

  @element_for_attribute: ->
    'data-predicate-selector'

  constructor: (@element) ->
    @insert_selector()
    @set_onchange_listener()
    @set_current_predicate()

  insert_selector: ->
    @_select = $("<select for='#{ $(@element).attr('id') }' class='#{ @constructor.CLASS_NAME }'><select>")
    for predicate in @_predicates()
      $(@_select).append("<option value='#{ predicate[0] }'>#{ predicate[0] }</option>")
    $(@_select).insertBefore(@element)

  set_onchange_listener: ->
    self = @
    $(@_select).change ->
      predicate = self.find_predicate_by_name $(@).val()
      self.set_name_to_element(predicate)

  set_name_to_element: (predicate) ->
    new_name = "q[#{ $(@element).attr('id').replace('q_', '') }_#{ predicate[1] }]"
    $(@element).attr('name', new_name)

  find_predicate_by_name: (name) ->
    for predicate in @_predicates()
      return predicate if predicate[0] is name

  set_current_predicate: ->
    if @current_predicate()
      $(@_select).val(@current_predicate()[0]).change()

  current_predicate: ->
    for predicate in @_predicates()
      return predicate if predicate[1] is $(@element).data('current-predicate')

###############################################################################

$ ->
  for element in $("[#{ PredicateSelector.element_for_attribute() }]")
    new PredicateSelector(element)

  $('.filter_form_select2').select2()

  $('.filter_form_date').datepicker
    dateFormat: 'yy-mm-dd'
