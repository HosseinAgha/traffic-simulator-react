require! {
  './moveCarsPassGreenLight'
  './getNumberOfWaitingCars'
  './isIntersection'
}

module.exports = (oldTrafficImm, answer, coeffs) ->
  oldTraffic = deimm oldTrafficImm
  { numOfIterations, totalWaitingTime, totalTravels, totalDistance } = deimm(answer)
  maxRowIndex = oldTraffic[0].length - 1
  maxColIndex = oldTraffic.length - 1
  totalMoves = 0
  { entryLambda, entryPeriod, smartTrafficLights, timerResetNum, carPassPerIteration } = coeffs

  newTraffic = oldTrafficImm
  for row, i in oldTraffic
    for node, j in row
      # calculate entries from gates
      queueToIncrease = isGate(i, j, maxRowIndex, maxColIndex)
      if queueToIncrease? # it is gate
        { pos } = queueToIncrease
        entriesCount = generateNumberOfGateEntry(entryLambda, entryPeriod, numOfIterations)
        totalTravels += entriesCount
        newCount = newTraffic.getIn([queueToIncrease.i, queueToIncrease.j, pos]) + entriesCount
        newTraffic = newTraffic.setIn [queueToIncrease.i, queueToIncrease.j, pos], newCount
      else if isIntersection(i, j, maxRowIndex, maxColIndex)  # update intersections data
        newTraffic = newTraffic.setIn [i, j, \greenlight], toggleGreenLight(oldTraffic, node, smartTrafficLights, carPassPerIteration, timerResetNum)
        { newTraffic, numOfMoves } = moveCarsPassGreenLight(newTraffic, oldTraffic, i, j, carPassPerIteration)
        totalMoves += numOfMoves
        newNodeState = newTraffic.getIn([i, j])

  numOfIterations++
  totalWaitingTime += ( getNumberOfWaitingCars(oldTraffic) - totalMoves )
  totalDistance += totalMoves

  answer = imm { numOfIterations, totalWaitingTime, totalTravels, totalDistance }      

  { traffic: newTraffic, answer }

isGate = (i, j, maxRowIndex, maxColIndex) ->
  switch
  | (i is 0 and (j isnt 0) and (j < maxRowIndex)) => { i: i + 1, j, pos: \top }
  | (i is maxColIndex and (j isnt 0) and (j < maxRowIndex)) => { i: i - 1, j, pos: \bottom }
  | (j is 0 and (i isnt 0) and (i < maxColIndex)) => { i, j: j + 1, pos: \left }
  | (j is maxRowIndex and (i isnt 0) and (i < maxColIndex)) => { i, j: j - 1, pos: \right }
  | _ => null

toggleGreenLight = (traffic, node, smartTimer, carPassPerIteration, resetValue = 20) ->  
  currentTimer = node.greenlight.timer
  if smartTimer
    if node.greenlight.dir is \vertical
      maxTraffic = Math.max node.top, node.bottom
    else
      maxTraffic = Math.max node.left, node.right
    iterationsToEmpty = Math.ceil(maxTraffic / carPassPerIteration)
    if iterationsToEmpty < currentTimer
      currentTimer = iterationsToEmpty + 1

  if currentTimer > 1
    dir = node.greenlight.dir
    timer = currentTimer - 1
  else
    dir = if node.greenlight.dir is \vertical then \horizontal else \vertical
    timer = resetValue

  imm { timer, dir }

generateNumberOfGateEntry = (lambda, period, iterationCount) ->
  return 0 if (iterationCount % period) isnt 0
  
  # calculate using poisson distribution
  r = 1
  count = 1
  while r > Math.pow(Math.E, -lambda)
    newR = Math.random!
    r = newR * r
    count++

  count