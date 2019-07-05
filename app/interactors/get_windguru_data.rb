class GetWindguruData < Interactor
	include ApplicationHelper

	def self.default
		endpoint = 'iapi.php'
		scrape_wind_data = new endpoint: endpoint
		scrape_wind_data.execute
	end

	def initialize(endpoint:)
		@endpoint = endpoint
		@intent_counter = 0
	end

	def execute
		@logs = get_wind_logs
		write_to_console 'SUCCESS' if @logs['fcst'].present?
		@logs
	end

	private

	def get_wind_logs
		4.times do
			@response = GetRequest.to(uri: uri, params: params, headers: headers)
			break if @response['fcst'].present?

			@intent_counter += 1
		end

		clean_response @response
	end

	def uri
		'https://www.windguru.net/int/' + @endpoint
	end

	def params
		query = '?q=forecast'
		query += '&id_model=29'

		query += '&initstr=' + initstr(@intent_counter)
		query += '&id_spot=261'
		query += '&WGCACHEABLE=21600'
		query += '&cachefix=-34.58x-58.4x30'
		query
	end

	def initstr intent
		# Four expected conbinations of the code,
		# from more probable to less probable
		case intent
		when 0
			DateTime.yesterday.strftime('%Y%m%d') + '18'
		when 1
			DateTime.now.strftime('%Y%m%d') + '06'
		when 2
			DateTime.now.strftime('%Y%m%d') + '00'
		else
			DateTime.now.strftime('%Y%m%d') + '18'
		end
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
