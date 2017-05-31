require! {
  'react': { Component }
  '$assets/svg/traffic-light2.svg' 
  '$assets/svg/gate2.svg' 
  '$assets/svg/car2.svg' 
  '$assets/svg/car.svg' 
  './TrafficNode.styl': css
  '$el': { div, el, svg }
}

module.exports = class TrafficNode extends Component
  ->
    super ...
    @state = {}

  render: ->
    div css.container, 
      style: @props.position
      children:
        @renderNode!

  renderNode: ->
    { node, entrance } = @props
    verticalGreen = node.greenlight.dir is \vertical
    div [css.nodeContainer, on, css.isEntrance, entrance, css.verticalGreen, verticalGreen], 
      children:
        @renderIcon entrance
        [ \left \right \top \bottom ].map (direction) ~>
          @renderRoad(direction, node[direction]) unless entrance and (direction isnt entrance)

  renderRoad: (direction, status) ->
    carSVG = if direction in [\top \bottom] then car else car2
    div [css.road, on, css[direction], direction], children:
      if status > 0
        div css.queue, children:
          svg carSVG, css.carIcon
          div css.count, children: status 

  renderIcon: (isEntrance) ->
    if isEntrance
      svg gate2, css.entranceIcon
    else
      svg traffic-light2, css.intersectionIcon 


