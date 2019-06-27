class GetCarpStationLogs < GetCarpData

	def execute
		super
		save_wind_logs
		save_gust_logs
		UpdateStatsEvent.default
		@logs
	end

	private

	def save_wind_logs
		wind_logs.each do |log|
			store_wind_log log
		end
	end

	def store_wind_log log
		log_date = parse_log_date log
		speed = log.last.to_f.round(1)
		direction = get_direction
		WindLog.create!(speed: speed, direction: direction, registered_date: log_date, station: station) unless WindLog.exists?(registered_date: log_date, station: station)
	end

	def wind_logs
		parsed_data.last['data']
	end

	def save_gust_logs
		gust_logs.each do |log|
			store_gust_log log
		end
	end

	def store_gust_log log
		log_date = parse_log_date log
		gust = log.last.to_f.round(1)

		wind_log = WindLog.where(registered_date: log_date, station: station)
		wind_log.update(gust: gust) if wind_log.exists?

	end

	def gust_logs
		parsed_data.first['data']
	end

	def parsed_data
		@logs['wind']['chart']['gust']['series']
	end

	def parse_log_date log
		clean_time = log.first.to_s.chomp('000')
		DateTime.strptime(clean_time, '%s')
	end

	def get_direction
		encoded_table = @logs['wind']['latest']
		decoded_table = URI.decode(encoded_table)
		result = Nokogiri::HTML(decoded_table)
		value = result.css('.rowAcolA').last.text
		value.to_f
	end

end
