coefficients = {
  1: 1, 2: .943, 3: .906, 4: .881, 5: .851, 6: .831, 7: .807, 8: .786, 9: .765, 10: .744
}
@LiftForm = React.createClass
  getInitialState: ->
    date: ''
    liftname: ''
    ismetric: false
    weightlifted: ''
    repsperformed: ''
    onerm: 0
  calculateOneRM: ->
    if @state.weightlifted && @state.repsperformed
      @state.onerm = @state.weightlifted / coefficients[@state.repsperformed]
    else
      0
  toggleUnit: (e) ->
    e.preventDefault()
    @setState ismetric: !@state.ismetric
  handleValueChange: (e) ->
    valueName = e.target.name
    @setState "#{ valueName }": e.target.value
  valid: ->
    @state.date && @state.liftname &&  @state.weightlifted && @state.repsperformed && @state.onerm
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '', { lift: @state }, (data) => 
      @props.handleNewLift data
      @setState @getInitialState()
    , 'JSON'
  render: ->
    React.DOM.form 
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'date'
          className: 'form-control'
          placeholder: 'Date'
          name: 'date'
          value: @state.date
          onChange: @handleValueChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'liftname'
          name: 'liftname'
          value: @state.liftname
          onChange: @handleValueChange
      React.DOM.div
        className: 'form-group'
        React.DOM.button
          className: 'btn btn-primary'
          onClick: @toggleUnit
          'Metric =' + @state.ismetric.toString()
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'nubmer'
          className: 'form-control'
          placeholder: 'weightlifted'
          name: 'weightlifted'
          value: @state.weightlifted
          onChange: @handleValueChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'nubmer'
          min: 1
          max: 10
          className: 'form-control'
          placeholder: 'Repsperformed'
          name: 'repsperformed'
          value: @state.repsperformed
          onChange: @handleValueChange
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Create Lift' 
      React.createElement OneRmBox, onerm: @calculateOneRM()
