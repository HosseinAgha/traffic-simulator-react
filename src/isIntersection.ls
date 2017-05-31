module.exports = (i, j, maxRowIndex, maxColIndex) ->
  isGate = 
    (i is 0) or
    (j is 0) or
    (i is maxColIndex) or
    (j is maxRowIndex) 
  
  not isGate