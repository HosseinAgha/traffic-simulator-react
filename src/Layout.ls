require! {
  'react'
  './Layout.styl': css
  '$el': { div, el }
}

module.exports = ({ children }) ->
  div css.container, children:
    el \h1, null, children: "Hello, world!"
    children
