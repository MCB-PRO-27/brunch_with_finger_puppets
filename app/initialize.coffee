# App Namespace
# Change `FooApp` to your app's name
@FooApp ?= {}
FooApp.routers ?= {}
FooApp.views ?= {}
FooApp.models ?= {}
FooApp.collections ?= {}

$ ->
    # Load App Helpers
    require 'lib/app_helpers'
    AppView = require 'views/app_view'
    View = require '../lib/view'
    require 'helpers/helpers'

    FooApp.views.appView = new AppView()

    Backbone.history.start pushState: yes