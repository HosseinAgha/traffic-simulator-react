require! {
  'path': path
  'webpack': webpack
  'case-sensitive-paths-webpack-plugin': CaseSensitivePathsPlugin
  'react-dev-utils/WatchMissingNodeModulesPlugin': WatchMissingNodeModulesPlugin
}  

module.exports = 
  entry:
    'react-hot-loader/patch'
    # activate HMR for React

    'webpack-dev-server/client?http://localhost:3000'
    # bundle the client for webpack-dev-server
    # and connect to the provided endpoint

    'webpack/hot/only-dev-server'
    # bundle the client for hot reloading
    # only- means to only hot reload for successful updates

    './src/entries/index.js'
    # the entry point of our app

  output: 
    filename: 'bundle.js'
    # the output bundle

    path: path.resolve __dirname, 'dist'

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

  plugins:
    new webpack.HotModuleReplacementPlugin
    # enable HMR globally

    new webpack.NamedModulesPlugin
    # prints more readable module names in the browser console on HMR updates

    new WatchMissingNodeModulesPlugin
    # Don't need to rerun webpack on npm install

    new webpack.NoEmitOnErrorsPlugin
    # do not emit compiled assets that include errors

  devServer: 
    host: \localhost

    overlay: true

    port: 3000

    historyApiFallback: true
    # respond to 404s with index.html

    hot: true
    # enable HMR on the server

