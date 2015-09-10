gulp = require 'gulp'
shell = require 'gulp-shell'

gulp.task('webpack:app', shell.task([
  './node_modules/.bin/webpack --config ./webpack.config.js'
]))

gulp.task('webpack:tests', shell.task([
  './node_modules/.bin/webpack --config ./test/webpack.config.js'
]))

gulp.task('watch', ->
  gulp.watch('./app/**/*.cjsx', ['webpack:app'])
  gulp.watch('./test/**/*.coffee', ['webpack:tests'])
)