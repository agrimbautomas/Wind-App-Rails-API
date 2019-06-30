class GetWindguruData < Interactor

	def self.default
		endpoint = 'iapi.php'
		scrape_wind_data = new endpoint: endpoint
		scrape_wind_data.execute
	end

	def initialize(endpoint:)
		@endpoint = endpoint
	end

	def execute
		response = GetRequest.to(uri: uri, params: params, headers: headers)
		@logs = clean_response response
	end

	private

	def uri
		'https://www.windguru.net/int/' + @endpoint
	end

	def params
		'?q=forecast&id_model=29&initstr=2019063006&id_spot=261&WGCACHEABLE=21600&cachefix=-34.58x-58.4x30'
	end

	def headers
		{
				'Content-Type' => 'application/x-www-form-urlencoded'
		}
	end

	def clean_response response
		JSON.parse(response)
	end


end
