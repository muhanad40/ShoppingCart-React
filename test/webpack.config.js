module.exports = {
  entry: "./testEntry.coffee",
  output: {
    filename: "test.js"
  },
  module: {
    loaders: [
      { test: /\.cjsx$/, loaders: ['coffee', 'cjsx']},
      { test: /\.coffee$/, loaders: ['coffee']}
    ]
  }
};