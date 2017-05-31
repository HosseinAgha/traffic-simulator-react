module.exports = (newTraffic, oldTraffic, i, j, numOfPass = 4) ->
  # move up to 4 cars if possible
  greenWays = 
    if oldTraffic[i][j].greenlight.dir is \horizontal
      [ \left \right ]
    else
      [ \top \bottom ]
      
  numOfMoves = 0
  for pos in greenWays
    { newTraffic, moveCount } = moveTheCarToNextQueue(pos, newTraffic, oldTraffic, i, j, numOfPass)
    numOfMoves += moveCount

  { newTraffic, numOfMoves }

moveTheCarToNextQueue = (pos, newTraffic, oldTraffic, i, j, numOfPass) ->
  return { newTraffic, moveCount: 0 } unless oldTraffic[i][j][pos] > 0
  newWay = generateCarDirection(pos)

  switch newWay
  | \left => 
    newi = i
    newj = j - 1
    nextQueuePos = \right
  | \right => 
    newi = i
    newj = j + 1
    nextQueuePos = \left
  | \top => 
    newi = i - 1
    newj = j
    nextQueuePos = \bottom
  | \bottom => 
    newi = i + 1
    newj = j
    nextQueuePos = \top

  moveCount = if oldTraffic[i][j][pos] < numOfPass then oldTraffic[i][j][pos] else numOfPass
  # console.log "from #i, #j, #pos to", newWay
  # console.log "#moveCount cars to to #nextQueuePos, #newi, #newj"
  # console.log "new car count is: ", oldTraffic[i][j][pos] - moveCount
  
  newTraffic = newTraffic.setIn [i, j, pos], (oldTraffic[i][j][pos] - moveCount)
  newTraffic = newTraffic.setIn [newi, newj, nextQueuePos], (oldTraffic[newi][newj][nextQueuePos] + moveCount)
  
  { newTraffic, moveCount }

generateCarDirection = (currectPos) ->
  r = Math.random!
  
  possibleTurns = [ \top \bottom \left \right ].filter (isnt currectPos)

  index = switch
  | (0 <= r < 0.33) => 0
  | (0.33 <= r < 0.66) => 1
  | (0.66 <= r <= 1) => 2

  possibleTurns[index]