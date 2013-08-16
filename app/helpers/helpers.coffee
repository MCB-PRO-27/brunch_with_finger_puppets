module.exports =

    Handlebars.registerHelper "getKey", (object) ->
        for prop of object
            return prop
        @

