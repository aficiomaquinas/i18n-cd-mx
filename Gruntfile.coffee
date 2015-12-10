module.exports = (grunt) ->	
	@initConfig
		
		##############################################
		
		coffeelint:
			app:
				files:
					src: ["web/coffee/main.coffee", "test/test.coffee", "web/coffee/pubpub.coffee"]
				options:
					configFile: 'coffeelint.json'

		coffee:
			options:
				bare: true
			app:
				expand: true
				cwd: 'web/coffee'
				src: ["**/*.coffee"]
				dest: "web/js"
				ext: '.js'
			test:
				expand: true
				cwd: 'web/test'
				src: ["**/*.coffee"]
				dest: "web/test"
				ext: '.js'

		compass:
			options:
				require: ['breakpoint-slicer']
				cssDir: "web/css"
				sassDir: "web/sass"
				imagesDir: "web/img"
				fontsDir: "web/css/fonts"
				javascriptsDir: "web/js"
				relativeAssets: true
				force: true
				raw: """
				preferred_syntax = :sass
				::Sass::Script::Number.precision = [10, ::Sass::Script::Number.precision].max
				sass_options = {:quiet => true}

				"""
			dev:
				options:
					outputStyle: 'expanded'
			prod:
				options:
					outputStyle: 'compressed'

		mochaTest:
			test:
				options:
					reporter: 'spec'
					clearRequireCache: true
					timeout: 5000
				src: ['test/test.js']

		##############################################

		watch:
			coffeeDev:
				options:
					spawn: true
					livereload: true
				files: ["web/**/**"]
				tasks: ['default']


	#######################################
	# Default task
	#######################################
	
	@registerTask 'default', [
		'coffeelint'
		'coffee'
		'compass:dev'
		'mochaTest'
	]

	#######################################
	@loadNpmTasks 'grunt-coffeelint'
	@loadNpmTasks 'grunt-contrib-coffee'
	@loadNpmTasks 'grunt-contrib-watch'
	@loadNpmTasks 'grunt-mocha-test'
	@loadNpmTasks 'grunt-contrib-compass'