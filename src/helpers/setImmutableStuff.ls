require! {
  'immutable': { fromJS }
}

global.imm = fromJS
global.deimm = (immutableData) ->
  return immutableData unless immutableData?
  immutableData.toJS!