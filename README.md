# Brunch with FingerPuppets and Foundation


Brunch with FingerPuppets is a [Brunch](http://brunch.io/) app skeleton. 

## Toolbox

- [CoffeeScript](http://coffeescript.org/)
- [Stylus](http://learnboost.github.com/stylus/)
- [Handlebars](http://handlebarsjs.com/)
- [Scaffolt](https://github.com/jbaumbach/nodejs-scaffolding/)

## Features

- [Swag v0.2.6](https://github.com/elving/swag)
- [Foundation 4](http://foundation.zurb.com/)
- [Font Awesome v3.0](https://github.com/FortAwesome/Font-Awesome)
- [Modernizr v2.6.2](https://github.com/Modernizr/Modernizr)
- [Brunch Auto-Reload v1.3.2](https://github.com/brunch/auto-reload-brunch)
- [Lodash v1.0.0-rc.3](https://github.com/bestiejs/lodash)
- [HTML5 Boilerplate v3.0.0](https://github.com/h5bp/html5-boilerplate)
- [Coffeelint v1.4.4](https://github.com/ilkosta/coffeelint-brunch)
- [SWFObject v2.2](http://code.google.com/p/swfobject/)
- [GSAP TweenMax v1.8.3](http://www.greensock.com/tweenlite/)


## Getting started Creating a new Application - then using watch so it automatically reloads

    brunch new <appname> --skeleton https://github.com/reduxdj/brunch_with_finger_puppets.git
    cd <appname>
    brunch w -s
    
or

    $ git clone git@github.com/reduxdj/brunch_with_finger_puppets.git
    $ cd brunch_with_foo
    $ npm install
    $ brunch new <appname>
    $ cd <appname>
    $ brunch w -s

or
    $ git clone git://github.com/reduxdj/brunch_with_finger_puppets.git && cd brunch_with_finger_puppets && sudo npm -g install && brunch w -s

## Example for generating a new application actor

    scaffolt <type> <name>
    ex: scaffolt model user

## Example reverting the cretaion of an Actor
    scaffolt <type> <name> -revert