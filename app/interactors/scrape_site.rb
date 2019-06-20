require "uri"
require "net/http"
require 'cgi'

class ScrapeSite < Interactor

	def self.by(endpoint:)
		scrape_site = new(endpoint: endpoint)
		scrape_site.execute
	end

	def initialize(endpoint:)
		@endpoint = endpoint
	end

	def execute
		exec_request
	end

	private

	def uri
		URI.parse(Settings.scraped_url) + @endpoint
	end

	def cookie
		CGI::Cookie.new(
				'name' => 'mariweb_session',
				'value' => 'c10e047655c87b01dbad8c20c8b63019',
				'path' => '/',
				'domain' => '.meteo.comisionriodelaplata.org',
				'httponly' => true,
				'expires' => Time.now + 1.year
		)
	end

	def headers
		{
				'Cookie' => cookie.to_s,
				'Content-Type' => 'application/x-www-form-urlencoded'
		}
	end

	def exec_request
		https = Net::HTTP.new(uri.host, uri.port)
		https.use_ssl = true

		req = Net::HTTP::Post.new(uri.path, headers)
		# req['c'] = 'telemetry%2FupdateTelemetry'
		# req['s'] = '0.8553524135681556'

		req.body = 'c=telemetry%2FupdateTelemetry&s=0.8553524135681556'
		res = https.request(req)

		res.body
	end

end
