require! {
  'material-ui/Slider': { default:Slider }
  './NumberWithLabel.styl': css
  'rc-input-number': { default:RCInputNumber }
  'rc-input-number/assets/index.css'
  '$el': { el, elem, div }
}

module.exports = (props) ->
  { max, min, value, onChange, label } = props

  div css.container, children:
    div css.label, children: label
    div css.inputContainer, children:
      elem RCInputNumber, { max, min, value, onChange }
