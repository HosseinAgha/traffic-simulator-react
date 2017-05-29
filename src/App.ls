 require! {
  'react': { Component }:React
  '$el': { el }
  './Layout.ls'
  './Counter.ls'
 } 

module.exports = class App extends Component
  render: ->
    el Layout, null, children: 
      el Counter
