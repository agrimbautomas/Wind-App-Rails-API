require "uri"
require "net/http"
require 'cgi'

class GetRequest < DoRequest

	private

	def exec_request

		uri = URI.parse(@uri + @params)
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		res = http.get(uri.request_uri)

		res.body
	end

end
