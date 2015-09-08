module.exports = {
  entry: "./testSpec.coffee",
  output: {
    filename: "test.js"
  },
  module: {
    loaders: [
      { test: /\.coffee$/, loaders: ['coffee']}
    ]
  }
};