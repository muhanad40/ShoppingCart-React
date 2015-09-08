module.exports = {
  entry: "./testSpec.cjsx",
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