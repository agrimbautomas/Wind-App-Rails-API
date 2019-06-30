require "uri"
require "net/http"
require 'cgi'

class DoRequest < Interactor

	def self.to(uri:, params:, headers:)
		scrape_site = new(uri: uri, params: params, headers: headers)
		scrape_site.execute
	end

	def initialize(uri:, params:, headers:)
		@uri = uri
		@params = params
		@headers = headers
	end

	def execute
		validate_uri
		validate_headers
		exec_request
	end

	private

	def validate_uri
		invalid "uri", "The uri is not valid" if @uri.blank?
	end

	def validate_headers
		invalid "headers", "The headers are invalid" if @headers.blank? or !@headers.kind_of? Hash
	end

end
