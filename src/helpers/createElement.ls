require! {
  'react': { createElement }
}

el = (element, classNames, props) ->

  if classNames
    propClassName = props.className or ""
    classNamesString = generateClassString(classNames) or ""
    props.className = "#{propClassName} #{classNamesString}" 

  createElement element, props

function generateClassString(classNames) 
  return classNames unless Array.isArray(classNames)
  classString = ""
  for name, index in classNames
    if ((index % 2) is 1) and name
      classString += "#{classNames[index - 1]} "

module.exports = 
  el: el
  div: el 'div', _, _
  input: el 'input', _, _
  img: el 'img', _, _
  span: el 'span', _, _