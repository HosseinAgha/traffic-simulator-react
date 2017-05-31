module.exports = (prevState, props) ->
  lastTraffic = prevState.prevTraffic.pop!
  lastAnswer = prevState.prevAnswer.pop!

  prevTraffic: prevState.prevTraffic
  prevAnswer: prevState.prevAnswer
  traffic: lastTraffic
  answer: lastAnswer