require! {
  'react': { Component }
  './SimulationPage.styl': css
  './getInitialTraffic'
  './StatesPanel'
  './getNumberOfWaitingCars'
  './TrafficNode'
  './SliderWithLabel'
  './NumberWithLabel'
  '$assets/svg/car.svg' 
  './moveSimulationForward'
  './moveSimulationBackward'
  'material-ui/RaisedButton': { default:RaisedButton }
  'material-ui/Toggle': { default:Toggle }
  'material-ui/svg-icons/av/play-arrow': { default:PlayIcon }
  'material-ui/svg-icons/av/pause': { default:PauseIcon }
  'material-ui/svg-icons/action/restore': { default:RestoreIcon }
  'material-ui/svg-icons/navigation/arrow-back': { default:BackIcon }
  'material-ui/svg-icons/navigation/arrow-forward': { default:NextIcon }
  '$el': { div, el, elem }
}

module.exports = class App extends Component

  @cityDimensions = width: 800, height: 640
  @numOfNodes = 4

  ->
    super ...

    initialCoeffs = 
      coeffs: imm do
        speed: 0.05
        entryLambda: 2
        entryPeriod: 10

    @state = 
      { ...initialCoeffs, ...@getInitialStateVariables! }

  getInitialStateVariables: ->
    traffic: imm getInitialTraffic(@@numOfNodes)
    prevTraffic: []
    prevAnswer: []
    answer: imm do
      numOfIterations: 0
      totalWaitingTime: 0
      totalTravels: 0
      totalDistance: 0

  render: ->
    div css.container, children:
      @renderControlPanel!
      @renderCityMap!
      @renderStatesPanel!

  renderCityMap: ->
    traffic = deimm @state.traffic
    { cityDimensions, numOfNodes } = @@
    endNode = numOfNodes - 1

    div css.city, 
      style: @@cityDimensions
      children:
        traffic.map (raw, i) ~>
          raw.map (node, j) ~>
            return if @isEdge(i, j, endNode)
            elem TrafficNode, 
              entrance: @getEntranceRoadDirection(i, j, endNode)
              position: 
                top: (cityDimensions.height / (numOfNodes - 1)) * i
                left: (cityDimensions.width / (numOfNodes - 1)) * j
              node: node

  renderStatesPanel: ->
    div css.statesPanel, children:
      elem StatesPanel,
        stateVariables: 
          deimm(@state.answer) <<< do
            waitingCarsNum: getNumberOfWaitingCars(deimm(@state.traffic))


  renderControlPanel: ->
    div css.controlPanel, children:
      @renderStartStopButton!
      @renderResetButton!
      @renderForwardBackwardButton!
      @renderConfigStuff!

  renderStartStopButton: ->
    el RaisedButton, css.panelButton,
      label: "Start/Pause" 
      primary: yes
      icon: elem if @state.simulationRunning then PauseIcon else PlayIcon 
      onClick: ~>
        if @state.simulationRunning then @pauseSimulation! else @startSimulation!

  renderResetButton: ->
    el RaisedButton, css.panelButton,
      label: "Reset" 
      secondary: yes
      icon: elem RestoreIcon
      onClick: ~> @resetSimulation!
    
  renderForwardBackwardButton: ->
    [
    el RaisedButton, css.panelButton,
      icon: elem BackIcon
      onClick: ~>  if @state.answer.get(\numOfIterations) > 0 then @iterateBack!
    el RaisedButton, css.panelButton,
      icon: elem NextIcon
      onClick: ~> @iterate!
    ]

  renderConfigStuff: ->
    div css.configsContainer, children:
      el Toggle, [css.panelButton, on, css.addBorder, on],
        label: "Smart Traffic Lights"
        onToggle: ~> 
          old = @state.coeffs.get(\smartTrafficLights)
          @setState coeffs: @state.coeffs.set(\smartTrafficLights, not(old))
        value: @state.coeffs.get(\smartTrafficLights)
      elem NumberWithLabel,
        min: 0
        label: "Entry Poisson Avg (λ)"
        value:  @state.coeffs.get(\entryLambda)
        onChange: (val) ~> 
          @setState coeffs: @state.coeffs.set(\entryLambda, val)
      
      elem NumberWithLabel,
        min: 0
        label: "Entry Poisson Period (s)"
        value:  @state.coeffs.get(\entryPeriod)
        onChange: (val) ~> 
          @setState coeffs: @state.coeffs.set(\entryPeriod, val)
      
      elem SliderWithLabel,
        label: "Speed (Tick Duration)"
        min: 0
        max: 1
        step: 0.01
        value: (1 - @state.coeffs.get(\speed))
        labelValue: @state.coeffs.get(\speed).toPrecision(1) + "s"
        disabled: @state.simulationRunning
        onChange: (e, val) ~>
          speed = @state.coeffs.get \speed 
          @setState coeffs: @state.coeffs.set(\speed, (1 - val))

  startSimulation: ->
    @setState simulationRunning: yes
    @interval = setInterval do
      ~> @iterate!
      @state.coeffs.get(\speed) * 1000

  pauseSimulation: ->
    @setState simulationRunning: no
    clearInterval @interval

  resetSimulation: ->
    @setState(@getInitialStateVariables!)    

  iterateBack: ->
    @setState moveSimulationBackward

  iterate: ->
    @setState moveSimulationForward

  getEntranceRoadDirection: (x, y, endNode) -> 
    switch
    | (x is 0) => \bottom
    | (y is 0) => \right
    | (x is endNode) => \top
    | (y is endNode) => \left
    | _ => null

  isEdge: (x, y, endNode) ->
    num = 0
    
    if (x is 0) then num++
    if (y is 0) then num++
    if (x is endNode) then num++
    if (y is endNode) then num++

    num > 1

