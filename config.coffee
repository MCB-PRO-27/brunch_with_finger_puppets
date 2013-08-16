exports.config =
    # See docs at http://brunch.readthedocs.org/en/latest/config.html.
    paths:
        public: 'bin'
    assets: [
      'assets'
      'vendor/img'
      'assets/fonts'
      'assets/images'
    ]
    vendor: [
      'vendor/scripts/jquery.js',
      'vendor/scripts/swag.js',
      'vendor/scripts/foundation/foundation.js',
      'vendor/scripts/lodash.js',
      'vendor/scripts/backbone.js',
      'vendor/scripts/selectRange.js',
      'vendor/scripts/swfobject.js'
      'vendor/scripts/gsap/easing/EassePack.js'
      'vendor/scripts/gsap/plugins/BezierPlugin.js'
      'vendor/scripts/gsap/plugins/ColorPropsPlugin.js'
      'vendor/scripts/gsap/plugins/CSSRulePlugin.js'
      'vendor/scripts/gsap/plugins/EaselPlugin.js'
      'vendor/scripts/gsap/plugins/RaphaelPlugin.js'
      'vendor/scripts/gsap/plugins/RoundPropsPlugin.js'
      'vendor/scripts/gsap/plugins/ScrollToPlugin.js'
      'vendor/scripts/gsap/plugins/TEMPLATE_Plugin.js'
      'vendor/scripts/gsap/TweenLite.js'
      'vendor/scripts/gsap/TweenMax.js'
      'vendor/scripts/gsap/jquery.gsap.js'
      'vendor/scripts/gsap/TimeLineLite.js'
      'vendor/scripts/gsap/TimeLineLineMax.js'
      'vendor'
    ]
    coffeelint:
        pattern: /^app\/.*\.coffee$/
        options:
            indentation:
                value: 4
                level: "error"
            max_line_length:
                value: 100
                level: "ignore"
    files:
        javascripts:
            joinTo:
                'javascripts/app.js': /^app/
                'javascripts/vendor.js': /^vendor/
                'test/javascripts/test.js': /^test(\/|\\)(?!vendor)/
                'test/javascripts/test-vendor.js': /^test(\/|\\)(?=vendor)/
            order:
                # Files in `vendor` directories are compiled before other files
                # even if they aren't specified in order.
                before: [
                    'vendor/scripts/jquery.js'
                    'vendor/scripts/foundation-4.3.1/foundation.js'
                    'vendor/scripts/lodash.js'
                    'vendor/scripts/jquery.touchswipe.1.1.1.js'
                    'vendor/scripts/backbone.js'
                    'vendor/scripts/swfobject.js'
                ]

        stylesheets:
            defaultExtension: 'styl'
            joinTo: 'stylesheets/app.css'
            order:
                before: [
                    'vendor/scripts/css/foundation.min.css'
                ]
                after: [
                    'vendor/styles/helpers.css'
                    'app/assets/views/styles'
                ]

        templates:
            defaultExtension: 'hbs'
            joinTo: 'javascripts/app.js'

    # Settings of web server that will run with `brunch watch [--server]`.
    server:
     # Path to your server node.js module.
     # If it's commented-out, brunch will use built-in express.js server.
        #path: 'server.coffee'
        #port: 3333
     # Run even without `--server` option?
        run: yes
