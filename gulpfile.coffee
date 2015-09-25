gulp      = require 'gulp'
path      = require 'path'
jade      = require 'gulp-jade'
stylus    = require 'gulp-stylus'
nib       = require 'nib'
prefixer  = require 'autoprefixer-stylus'
coffee    = require 'gulp-coffee'
cache     = require 'gulp-cached'
bower     = require 'gulp-bower'
flatten   = require 'gulp-flatten'
plumber   = require 'gulp-plumber'
imagemin  = require 'gulp-imagemin'

gutil     = require 'gulp-util'
connect   = require 'gulp-connect'
autowatch = require 'gulp-autowatch'

versions = [
  'last 5 versions',
  '> 1%',
  'ie 8', 'ie 7',
  'Android 4',
  'Blackberry 10'
]

paths =
  jade  : 'src/templates/**/*.jade'
  stylus: 'src/styles/**/*.styl'
  coffee: 'src/scripts/**/*.coffee'
  images: 'src/images/**/*'
  bower : 'bower_components'
  output: 'builds/development'

gulp.task 'jade', ->
  gulp.src paths.jade
    .pipe plumber()
    .pipe jade {pretty: true}
    .pipe gulp.dest paths.output
    .pipe connect.reload()

gulp.task 'stylus', ->
  gulp.src 'src/styles/main.styl'
    .pipe plumber()
    .pipe stylus(
      use: [
        nib(),
        prefixer(versions, {cascade: true})
      ],
      import:[
        'nib'
        ])
    .pipe gulp.dest paths.output + '/css'
    .pipe connect.reload()

gulp.task 'coffee', ->
  gulp.src paths.coffee
    .pipe plumber()
    .pipe coffee({bare: true}).on 'error', gutil.log
    .pipe gulp.dest paths.output + '/js'
    .pipe connect.reload()

gulp.task 'bower', ->
  gulp.src 'bower_components/**/*.min.js'
    .pipe flatten()
    .pipe gulp.dest paths.output + '/vendor/js'
    .pipe connect.reload()

gulp.task 'images', ->
  gulp.src paths.images
    .pipe imagemin({progressive: true})
    .pipe cache 'images'
    .pipe gulp.dest paths.output + '/images'
    .pipe connect.reload()

gulp.task 'connect', ->
  connect.server
    root: paths.output
    port: 3000
    livereload: true

gulp.task 'watch', ->
  autowatch gulp, paths

gulp.task 'default', ['jade','stylus', 'coffee', 'images','connect', 'watch', 'bower']
