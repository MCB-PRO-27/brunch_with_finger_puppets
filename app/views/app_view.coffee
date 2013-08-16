View = require '../lib/view'
template = require '../views/templates/app_view'
speed = 

class AppView extends View
    template: template
    className: 'app-view'
    events:
        'click .top-nav a' : 'openColumn'
        'mouseDown .top-nav a' : 'openColumn'
        'click .column a' : 'closeMenu'
        'click .up-icon' : 'closeMenu'
        'click .nav-icon.icon-chevron-left' : 'pageLeft'
        'click .nav-icon.icon-chevron-right' : 'pageRight'
        'mouseDown .nav-icon.icon-chevron-left': 'pageLeft'
        'mouseDown .nav-icon.icon-chevron-right': 'pageRight'

    menuMap:
        'fingers' : { 'type' : 'menu', 'columnFamily' : 'fingers' }
        'girls': { 'type' : 'column', 'columnFamily' : 'main' }
        'guys' : {'type' : 'column', 'columnFamily' : 'main' }
        'magazine' : {'type' : 'menu', 'columnFamily' : 'magazine' }
        'popular' : {'type' : 'menu', 'columnFamily' : 'popular' }
        'friends' : {'type' : 'menu', 'columnFamily' : 'friends' }

    onReset: () ->
        f = => 
            $('.inner-menu').css( marginLeft: 0 )
            @showLeft() if @hasLeft()
            @showRight() if @hasRight()
         _.throttle(f, 500)

    resetActiveColumnToZero: () ->
        @getActiveColumHolder().css('marginLeft',0)

    closeMenu: () ->
        @$el.find('.icon-chevron-left').css(opacity:0)
        @$el.find('.icon-chevron-right').css(opacity:0)
        @$el.find('.up-icon').css(opacity:0)
        @tl = tl = new TimelineLite({overwrite:1})
        t1 = TweenMax.to @$('.spacer.top'), .3 , { opacity: 0 ,ease: Strong.easeOut}
        t2 = TweenMax.to @$el.find('.menu') , 0.5 , {opacity:0 , ease: Strong.easeOut}
        t3 = TweenMax.to @$el.find('.scrollable-content') , 0.5 , {marginTop: 0,paddingTop:100, ease: Strong.easeOut }
        tl.appendMultiple [t1, t2, t3] , 0, "stagger", 0

    initialize: () ->
        super
        @render()
        @delegateSwipeEvents()
        $(window).resize => TweenMax.to $('.inner-menu'), .5, {marginLeft: 0  }

    render: () ->
        super
        $('body').append @$el.html @template()
        return @

    hasLeft: () -> @$el.find('.column-holder.active .column.active').prev('.column').length > 0

    hasRight: () -> @$el.find('.column-holder.active .column.active').next('.column').length > 0

    getActiveColumn: () -> @$el.find('.column.active')

    getActiveColumnWidth: () ->
        @getActiveColumn().outerWidth()

    getActiveColumHolder: () ->
        @$el.find('.column-holder.active')

    showUpIcon: () ->
         TweenMax.to @$el.find('.up-icon'), .5, {opacity: .8}

    setActiveColumn: () ->
        items = @$el.find('.column-holder.active .column')
        _.each items, (el) -> 
            if $(el).position().left is 0 
                $(el).addClass('active') 
            else
                $(el).removeClass('active') 
        
    setNextColumnActive: ( el ) ->
        @$('.column').removeClass('active')
        _.defer -> $(el).addClass('active') if el
        _.defer => @setActiveMenu(el) if el
        _.defer => 
            @showLeft()
            @showRight()
            @showUpIcon()

    removeActiveColumns: () ->
        @$el.find('.column-holder.active .column').removeClass('active')

    pageRight: (event) -> 
        event.stopPropagation() if event
        f = =>  
            @setNextColumnActive( @getActiveColumn().next()[0] )  if @getActiveColumn().next().length > 0 
            @setActiveMenu()
        TweenMax.to $('.inner-menu'), .5, {marginLeft: "-=#{@getActiveColumnWidth()}", onComplete:  f } if @hasRight()
      
    pageLeft: (event) ->
        event.stopPropagation() if event
        f = =>
            @setNextColumnActive( @getActiveColumn().prev()[0] ) if @getActiveColumn().prev().length > 0 
            @setActiveMenu()
        TweenMax.to $('.inner-menu'), .5, {marginLeft: "+=#{@getActiveColumnWidth()}", onComplete: f } if @hasLeft()

    pageUp: () ->
        @closeMenu()

    setActiveMenu: ( el ) ->
        @$el.find('.top-nav a').removeClass('active')
        name = @getActiveColumn().find('h6 a').text()
        if name is "Women"
            @$el.find('.top-nav a.women').addClass('active')
        else if name is "Men"
            @$el.find('.top-nav a.men').addClass('active')
        else if @getActiveColumHolder().hasClass('brands')
            @$el.find('.top-nav a.brands').addClass('active')
            
    pageDown: () ->
        console.log 'pageDown'

    showLeft: () ->
        opc = if @hasLeft() then 0.8 else 0
        @$el.find('.icon-chevron-left').css(opacity:opc)
        @showUpIcon()

    showRight: () ->
        opc = if @hasRight() then 0.8 else 0
        @$el.find('.icon-chevron-right').css(opacity:opc)
        @showUpIcon()

    delegateSwipeEvents: () ->
        $(".column").touchwipe
          wipeLeft: => @pageRight()
          wipeRight: => @pageLeft()
          wipeUp: => @pageUp()
          wipeDown: =>  @pageDown()
          min_move_x: 12
          min_move_y: 12
          preventDefaultEvents: true

    openColumn: ( event ) ->
        targetName = $(event.target).html()
        @$('.column').removeClass('active')
        @$('.top-nav li a').removeClass('active')
        _.defer -> $(event.target).addClass('active')
        @tl = tl = new TimelineLite({overwrite:1})
        t1 = TweenMax.to @$el.find('.scrollable-content') , 0.5 , {marginTop: 370, ease: Strong.easeInOut,paddingTop:0 }
        t2 = TweenMax.to @$('.menu') , 1 , { opacity: 1 , ease: Strong.easeOut, top: 90 }
        t3 = TweenMax.to @$('.spacer.top'), 1 , { opacity: 1 }
        tl.appendMultiple [t1, t2, t3].concat( @handleMenuNavigation targetName) , 0, "stagger", 0.1
        $('.column').removeClass('active')

    setActiveColumnHolder: (name) ->
        @$('.column-holder').removeClass('active')
        @$el.find('.column-holder.'+name).addClass('active')

    setActiveColumn: ( name ) ->
        @$('.column').removeClass('active')
        f = =>
            @$('.column.'+name).addClass('active')
            if @$('.column.'+name).length is 0
                TweenMax.to $('.inner-menu'), .5, {marginLeft: 0} 
        _.defer f

    scrollMenuYtoName: ( name ) ->
        @setActiveColumnHolder( name )
        @setActiveColumn( name )
        f = => 
            @showLeft()
            @showRight()
        yPos = $('.column-holder.'+name).attr('data-top')*-1
        TweenMax.to $('.inner-menu'), .5, {marginTop: yPos , onComplete: f }
   
    scrollColumnXtoName: ( name ) ->
        @setActiveColumnHolder( name )
        @setActiveColumn( name )
        f = => 
            @showLeft()
            @showRight()
        if $('.column.'+name).length > 0
            xPos = Math.min $('.column.'+name).position().left*-1, 0
            TweenMax.to $('.inner-menu'), .5, {marginLeft: xPos, f  }
        else
           TweenMax.to $('body'), 0 , {opacity: 1}

    handleMenuNavigation: ( name ) ->
        [ @scrollColumnXtoName(name), @scrollMenuYtoName( @menuMap[name].columnFamily ) ] 

module.exports = AppView