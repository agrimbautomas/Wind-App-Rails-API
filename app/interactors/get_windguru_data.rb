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
		query = '?q=forecast'
		query += '&id_model=29'
		query += '&initstr=' + DateTime.now.strftime('%Y%m%d') + '06'
		query += '&id_spot=261'
		query += '&WGCACHEABLE=21600'
		query += '&cachefix=-34.58x-58.4x30'
		query
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
