require('livescript');

var config;
if(process.env.NODE_ENV === 'production')
  config = require('./webpack.config.prod.ls');
else
  config = require('./webpack.config.ls');

module.exports = config;