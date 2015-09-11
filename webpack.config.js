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
      { test: /\.cjsx$/, loaders: ['coffee', 'cjsx']}
    ]
  }
};