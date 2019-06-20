require "uri"
require "net/http"
require 'cgi'

class PostRequest < Interactor

	def self.to(uri:, headers:)
		scrape_site = new(uri: uri, headers: headers)
		scrape_site.execute
	end

	def initialize(uri:, headers:)
		@uri = uri
		@headers = headers
	end

	def execute
		# validate_uri
		# validate_headers

		exec_request
	end

	private

	def exec_request
		https = Net::HTTP.new(@uri.host, @uri.port)
		https.use_ssl = true

		req = Net::HTTP::Post.new(@uri.path, @headers)
		# req['c'] = 'telemetry%2FupdateTelemetry'
		# req['s'] = '0.8553524135681556'

		req.body = 'c=telemetry%2FupdateTelemetry&s=0.8553524135681556'
		res = https.request(req)

		res.body
	end

	def validate_uri
		invalid "uri", "The uri is not valid" if @uri.blank?
	end

	def validate_headers
		invalid "headers", "The headers are invalid" if @headers.blank? or !@headers.kind_of? Hash
	end

end
