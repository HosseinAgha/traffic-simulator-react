require! {
  './getNextSimulationData'
}

module.exports = (prevState, props) ->
  coeffs = deimm(prevState.coeffs)
  { traffic, answer } = getNextSimulationData prevState.traffic, prevState.answer, coeffs

  answer: answer
  traffic: traffic
  prevTraffic: prevState.prevTraffic.concat prevState.traffic
  prevAnswer: prevState.prevAnswer.concat prevState.answer