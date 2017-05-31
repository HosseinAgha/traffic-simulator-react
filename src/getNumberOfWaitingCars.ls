require! {
  './isIntersection'
}

module.exports = (traffic) ->
  maxColIndex = traffic.length - 1
  maxRowIndex = traffic.0.length - 1

  totalWaiting = 0
  inter = 0

  for row, i in traffic
    for node, j in row
      if isIntersection(i, j, maxRowIndex, maxColIndex)
        inter++
        totalWaiting += node.left + node.right + node.top + node.bottom 

  totalWaiting