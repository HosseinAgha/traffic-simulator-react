require! {
  'path': path
  'webpack': webpack
}  

module.exports = 
  entry:
    './src/entries/index.js'
    # the entry point of our app

  output: 
    filename: 'bundle.js'
    # the output bundle

    path: path.resolve __dirname, 'static/dist'

    publicPath: '/static/'
    # necessary for HMR to know where to load the hot update chunks
  
  resolve: 
    alias: 
      '$el': path.resolve __dirname, 'src/helpers/createElement.ls'
      '$assets': path.resolve __dirname, 'assets'
    
    extensions: ['.ls' '.js' '.jsx']
  
  devtool: 'cheap-module-eval-source-map'

  module: 
    rules:
      * test: /\.jsx?$/
        loaders: [ 'babel-loader' ]
        exclude: /node_modules/

      * test: /\.ls$/
        loaders:
          'react-hot-loader/webpack'
          'livescript-loader?map=embedded'
        exclude: /node_modules/

      * test: /\.css$/
        loaders: ['style-loader', 'css-loader']

      * test: /\.styl$/
        loaders:
          * loader: 'style-loader'
          * loader: 'css-loader'
            options: 
              module: true
              sourceMap: true
              localIdentName: '[name]_[local]_[hash:base64:3]'
          * loader: 'stylus-loader'
        exclude: /node_modules/

      * test: /\.svg$/
        loaders: 
          'babel-loader'
          'react-svg-loader'
        exclude: /node_modules/