module.exports = {
  entry: "./testEntry.coffee",
  output: {
    filename: "testBundle.js"
  },
  module: {
    loaders: [
      { test: /\.cjsx$/, loaders: ['coffee', 'cjsx']},
      { test: /\.coffee$/, loaders: ['coffee']}
    ]
  }
};