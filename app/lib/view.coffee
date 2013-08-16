Model = require 'lib/model'

module.exports = class View extends Backbone.View
    debug: on

    startDebugging: ->
        @on "#{@cid}:initialize", -> console.debug "Initialized #{@name}", @
        @on "#{@cid}:render", -> console.debug "Rendered #{@name}", @
        @on "#{@cid}:update", -> console.debug "Updated #{@name}", @
        @on "#{@cid}:destroy", -> console.debug "Destroyed #{@name}", @

    type: 'view'

    name: null

    autoRender: off

    rendered: no

    model: new Model()

    template: -> ''

    # Event Methods
    delegateEvents: (events) ->
        Backbone.View::delegateEvents.call this, events
        # bind the remove method to when the element is removed
        @$el.bind "DOMElementRemoved" + @eventNamespace, _.bind(@remove, this)

    ###
    Dispatch an event to on the view's element

    @param eventName - String - name of event to dispatch
    @params ...rest - parameters to pass to event handlers
    @return View - current view
    ###
    dispatch: (eventName) ->
        @$el.trigger eventName, _.rest(arguments_)
        this

    # jQuery Shortcuts

    ###
    Get the descendants of each element in the view's element, filtered by a selector, jQuery object, or element.

    @param selector - String/jQuery/DOMElement - selector to filter the current view element by
    @return jQuery
    ###
    find: (selector) ->
        @$ selector


    remove: ->
        self = this
        # remove the event bindings
        @undelegateEvents()
        
        # remove all registered events from the model
        if self.model
            if typeof self.model.off is "function"
                self.model.off null, null, self
          
        # check if we have the case when the model is
        # just a wrapper for sub models!
        else if _.isObject(self.model)
            _.each _.values(self.model), (model) ->
            model.off null, null, self  if model and typeof model.off is "function"

        
        # remove all registered events from the model
        self.collection.off null, null, self  if self.collection and typeof self.collection.off is "function"
        Backbone.View::remove.call this
        self

    ###
    Append a view to the current view.

    @param view - element/jQuery/View - an element, View or jQuery Object to append to the current view's DOM element
    @return View - current view
    ###

    appendView: (view) ->
        if view instanceof View
            # call the appendTo method on the view
            view.appendTo this
        else if view instanceof Backbone.View
            @$el.append view.$el
            view.render()
        else
      
            # it's a DOM element, just append to our view
            @$el.append view
        this

  
    ###
    Insert a view into the currentView's element

    @param view - element/jQuery/View - an element, View or jQuery Object
    @param el - element you wan to insert at in the current view
    @return View - current view
    ###
    appendToElement: (view, el) ->
        if view instanceof View
          
            # call the appendTo method on the view
            view.appendTo @find(el)
        else if view instanceof Backbone.View
            @find(el).append view.$el
            view.render()
        else
            # it's a DOM element, just append to our view
            @$el.find(el).append view
        this

    ###
    Prepend a view to the current view.
  
    @param view - element/jQuery/View - an element, View or jQuery Object to prepend to the current view's DOM element
    @return View - current view
    ###
    prependView: (view) ->
        if view instanceof View
            # call the prependTo method on the view
            view.prependTo this
        else if view instanceof Backbone.View
            @$el.prepend view.$el
            view.render()
        else
      
        #it's a DOM element, just prepend to our view
        @$el.prepend view
        this

    ###
    Append current view to another view
  
    @param view - element/jQuery/View - an element, View or jQuery Object to add the current view to
    @return View - current view
    ###
    appendToView: (view) ->
        el = @$el
        if view instanceof Backbone.View
            view.$el.append el
        else
            $(view).append el
        @render()
        this
    
    ###
    Prepend current view to another view

    @param view - element/jQuery/View - an element, View or jQuery Object to prepend the current view to
    @return View - current view
    ###
    prependToView: (view) ->
        el = @$el
        if view instanceof Backbone.View
            view.$el.prepend el
        else
        $(view).prepend el
        @render()
        this

    ###
    Insert a view into the currentView's element

    @param view - element/jQuery/View - an element, View or jQuery Object
    @param el - element you wan to insert at in the current view
    @return View - current view
    ###
    appendToElement: (view, el) ->
        if view instanceof View
            # call the appendTo method on the view
            view.appendTo @find(el)
        else if view instanceof Backbone.View
            @find(el).append view.$el
            view.render()
        else
            # it's a DOM element, just append to our view
            @$el.find(el).append view
        @

    html: (dom) ->
        @$el.html(dom)
        @trigger "#{@cid}:#{if @rendered then 'update' else 'render'}", @
        @$el

    append: (dom) ->
        @$el.append(dom)
        @trigger "#{@cid}:#{if @rendered then 'update' else 'render'}", @
        @$el

    prepend: (dom) ->
        @$el.prepend(dom)
        @trigger "#{@cid}:#{if @rendered then 'update' else 'render'}", @
        @$el

    after: (dom) ->
        @$el.after(dom)
        @trigger "#{@cid}:update", @
        @$el

    before: (dom) ->
        @$el.after(dom)
        @trigger "#{@cid}:update", @
        @$el

    css: (css) ->
        @$el.css(css)
        @trigger "#{@cid}:update", @
        @$el

    find: (selector) ->
        @$el.find(selector)

    afterRender: ()->
        @

    beforeRender: () ->
        @

    delegate: (event, selector, handler) ->
        handler = selector if arguments.length is 2
        handler = (handler).bind @

        if arguments.length is 2
            @$el.on event, handler
        else
            @$el.on event, selector, handler

    # Use bootstrap method instead of initialize
    bootstrap: ->

    initialize: ->
        @bootstrap()
        @name = @name or @constructor.name
        @startDebugging() if @debug is on
        @render() if @autoRender is on
        @trigger "#{@cid}:initialize", @

    getRenderData: ->
        @model?.toJSON()

    render: ->
        @trigger "#{@cid}:render:before", @
        @beforeRender()
        @$el.attr('data-cid', @cid)
        @html @template(@getRenderData())
        @rendered = yes

        @trigger "#{@cid}:render:after", @
        @afterRender()
        @

    destroy: (keepDOM = no) ->
        @trigger "#{@cid}:destroy:before", @

        if keepDOM then @dispose() else @remove()
        @model?.destroy()

        @trigger "#{@cid}:destroy:after", @
