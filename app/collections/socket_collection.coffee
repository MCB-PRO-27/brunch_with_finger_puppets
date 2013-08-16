Collection = require '../lib/collection'

class SocketCollection extends Collection
	constructor: (@name) ->
		@delegateSocketEvents @socket_events  if @socket_events and _.size(@socket_events) > 0
		super

  delegateSocketEvents: (events) ->
    for key of events
      method = events[key]
      method = this[events[key]]  unless _.isFunction(method)
      throw new Error("Method \"" + events[key] + "\" does not exist")  unless method
      method = _.bind(method, this)
      window.app.socket.on key, method