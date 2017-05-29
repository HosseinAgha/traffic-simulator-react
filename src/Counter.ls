require! {
  'react': { Component }:React
  '$el': { el }
}

module.exports = class Counter extends Component
  (props) ->
    super props
    @state = { counter: 0 }

  componentDidMount: ->
    @interval = setInterval(@tick.bind(this), 1000)

  tick: ->
    @setState({ counter: @state.counter + 1 })

  componentWillUnmount: ->
    clearInterval(@interval);

  render: ->
    el \h2, null, children: "Counter: #{@state.counter}"
