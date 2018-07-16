const   gulp          = require('gulp'),
		gutil         = require('gulp-util' ),
		sass          = require('gulp-sass'),
		browsersync   = require('browser-sync'),
		concat        = require('gulp-concat'),
		uglify        = require('gulp-uglify'),
		cleancss      = require('gulp-clean-css'),
		rename        = require('gulp-rename'),
		autoprefixer  = require('gulp-autoprefixer'),
		notify        = require("gulp-notify"),
		rsync         = require('gulp-rsync'),
		gcmq          = require('gulp-group-css-media-queries'),
		jsmin         = require('gulp-jsmin'),
	
		debug         = require('gulp-debug'),
		remember      = require('gulp-remember'),
		cached        = require('gulp-cached'),
		coffee        = require('gulp-coffee');


gulp.task('coffee', function(){
	gulp.src('./assets/coffee/*.coffee')
	
	.pipe(cached('coffee'))
	.pipe(remember('coffee'))
	.pipe(debug({title: "coffee"}))
	.pipe(coffee({bare: true})).on('error', notify.onError())
	.pipe(gulp.dest('./js/'))
	.pipe(browsersync.reload( {stream: true} ))
});

// gulp.task('js', function() {
// 	return gulp.src([
// 		'./js/main.js',
// 		'./js/onbutton.js',
// 		'./js/spinner.js'
//
// 		])
// 	.pipe(concat('app.js'))
// 	.pipe(gulp.dest('./js'))
// 	.pipe(browsersync.reload({ stream: true }))
// });

gulp.task('browser-sync', function() {
	browsersync({
		server: "./"
	})
	
	
});

gulp.task('sass', function() {
	return gulp.src('./assets/sass/**/*.sass')
	.pipe(sass({ outputStyle: 'expan' }).on("error", notify.onError()))
	.pipe(gcmq())
	.pipe(autoprefixer(['last 15 versions']))
	.pipe(gulp.dest('./css'))
	.pipe(browsersync.reload( {stream: true} ))
});

gulp.task('watch', ['coffee','sass', 'browser-sync'], function() {
	gulp.watch('./assets/sass/**/*.sass', ['sass']);
	gulp.watch('./assets/coffee/**/*.coffee', ['coffee']);
	
	// gulp.watch(['js/**/*.js'], ['js']);
	gulp.watch('./*.html', browsersync.reload);
});

gulp.task('default', ['watch']);
