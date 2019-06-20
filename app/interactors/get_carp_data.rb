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
		response = ScrapeSite.by(endpoint: @endpoint)
		@logs = clean_response response
	end

	private

	def clean_response response
		response.slice! 'OKdoneLoadingTelemetry|JSON**'
		JSON.parse(response)
	end

end
