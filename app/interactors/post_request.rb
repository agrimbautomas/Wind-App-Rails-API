require "uri"
require "net/http"
require 'cgi'

class PostRequest < DoRequest

	private

	def exec_request
		https = Net::HTTP.new(@uri.host, @uri.port)
		https.use_ssl = true
		req = Net::HTTP::Post.new(@uri.path, @headers)

		req.body = @params
		res = https.request(req)

		res.body
	end

end
