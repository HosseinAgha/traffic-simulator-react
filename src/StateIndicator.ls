require! {
  'react': { Component }
  './StateIndicator.styl': css
  '$el': { div, el, elem }
}

module.exports = (props) ->
  div css.container, children:
    div [css.labelValue, on, css.label, on], children: props.label
    div [css.labelValue, on, css.value, on], children: props.value