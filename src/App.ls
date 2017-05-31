 require! {
  'react': { Component }:React
  '$el': { el, elem }
  './SimulationPage'
  './setTapEventPlugin'
  'material-ui/styles/MuiThemeProvider': MuiThemeProvider
 } 
 
module.exports = class App extends Component
  render: ->
    elem MuiThemeProvider.default, children:
      el SimulationPage
