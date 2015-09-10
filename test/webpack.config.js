module.exports = {
  entry: __dirname + "/testEntry.coffee",
  output: {
    path: __dirname,
    filename: "testBundle.js"
  },
  module: {
    loaders: [
      { test: /\.cjsx$/, loaders: ['coffee', 'cjsx']},
      { test: /\.coffee$/, loaders: ['coffee']}
    ]
  }
};