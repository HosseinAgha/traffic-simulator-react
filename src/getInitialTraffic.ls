module.exports = (dim = 4) ->

  # use an comprehension to generate 2 dimentional array
  for x til dim
    for y til dim
      { 
        greenlight: 
          timer: 0
        right: 0 
        left: 0 
        top: 0 
        bottom: 0 
      }

