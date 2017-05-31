require! {
  'react': { PureComponent }
  './StatesPanel.styl': css
  './StateIndicator'
  '$el': { div, el, elem }
}

module.exports = class App extends PureComponent

  render: ->
    { numOfIterations, totalWaitingTime, totalTravels, waitingCarsNum, totalDistance } = @props.stateVariables
    finishedCarsNum = (totalTravels - waitingCarsNum) or 1
    
    div css.container, children:
      elem StateIndicator, 
        label: "Number of iterations"
        value: numOfIterations
      elem StateIndicator, 
        label: "Total Car Travels"
        value: totalTravels
      elem StateIndicator, 
        label: "% Of Cars Finished Trip"
        value: ((finishedCarsNum / (totalTravels or 1)) * 100).toPrecision(3) + "%"   
      elem StateIndicator, 
        label: "Number of Cars Waiting"
        value: waitingCarsNum
      elem StateIndicator, 
        label: "Avg trip time"
        value: ( numOfIterations / finishedCarsNum ).toPrecision(2) + " Its"
      elem StateIndicator, 
        label: "Avg Waiting Time"
        value: (totalWaitingTime / (totalTravels or 1)).toPrecision(3) + " s"
      elem StateIndicator, 
        label: "Avg Distance (each road 1KM)"
        value: (totalDistance / (totalTravels or 1)).toPrecision(2) + " km"
      elem StateIndicator, 
        label: "Total Waiting Time"
        value: totalWaitingTime + " s"
      elem StateIndicator, 
        label: "Total Distance (each road 1KM)"
        value: totalDistance + " km"
      
      