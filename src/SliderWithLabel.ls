require! {
  'material-ui/Slider': { default:Slider }
  './SliderWithLabel.styl': css
  '$el': { el, div }
}

module.exports = (props) ->
  { max, min, value, labelValue, onChange, disabled, label } = props

  div css.container, children:
    div css.label, children: label + " (#labelValue) "
    el Slider, css.slider, { max, min, value, onChange, disabled }
