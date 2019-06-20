# Get "Comision Administradora del Rio de la Plata" data
class GetCarpData < Interactor

	def self.default
		endpoint = 'ecsCommand.php'
		scrape_wind_data = new endpoint: endpoint
		scrape_wind_data.execute
	end

	def initialize(endpoint:)
		@endpoint = endpoint
	end

	def execute
		response = PostRequest.to(uri: uri, headers: headers)
		@logs = clean_response response
	end

	private

	def uri
		URI.parse(Settings.scraped_url) + @endpoint
	end

	def headers
		{
				'Cookie' => cookie.to_s,
				'Content-Type' => 'application/x-www-form-urlencoded'
		}
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

	def clean_response response
		response.slice! 'OKdoneLoadingTelemetry|JSON**'
		JSON.parse(response)
	end


end
