var webpack = require("webpack");

module.exports = {
  entry: __dirname + "/app/app.cjsx",
  output: {
    path: __dirname + "/public",
    filename: "bundle.js"
  },
  resolveLoader: {
    modulesDirectories: ['node_modules']
  },
  module: {
    loaders: [
      { test: /\.(jpe?g|gif|png)(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "file-loader" },
      { test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "url-loader?limit=10000&minetype=application/font-woff" },
      { test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "file-loader" },
      { test: /\.css$/, loader: "style-loader!css-loader" },
      { test: /\.cjsx$/, loaders: ['coffee', 'cjsx']}
    ]
  },
  plugins: [
    new webpack.ProvidePlugin({
      // $: "jquery",
      jQuery: "jquery",
      // "window.jQuery": "jquery",
      // "root.jQuery": "jquery"
    })
  ]
};