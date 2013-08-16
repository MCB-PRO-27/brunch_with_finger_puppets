Collection = require '../lib/collection'
class PagingCollection extends Collection

	parse:(response) ->
		resp = parser(response)
		if resp.isSuccess
			if typeof resp.paging is "object"
				@currentPage = resp.paging.page
				@totalItems = resp.paging.total
				@pageSize = resp.paging.per_page
			(if _.isArray(resp.data) then resp.data else [resp.data])
		else

			# throw entire response object, 
			# containing error code and msg
			throw
				error: resp.error
				message: resp.message
				statusCode: resp.statusCode


module.exports = PagingCollection