class GetWindguruBsasLogs < GetWindguruData

	def execute
		super
		save_logs
		UpdateStatsEvent.default
		@logs
	end

	private

	def save_logs
		time_logs.each_with_index do |log, e|

			store_wind_log(e) if log.to_i >= current_hour and log.to_i < current_hour + 3

			break if log.to_i > current_hour + 3
		end
	end

	def store_wind_log index
		speed = speed_logs[index].to_f.round(1)
		gust = gust_logs[index].to_f.round(1)
		direction = direction_logs[index]
		log_date = Time.now.change(hour: time_logs[index])
		WindLog.create!(speed: speed, direction: direction, gust: gust, registered_date: log_date, station: station)
	end

	def station
		Station.find_by_slug('windguru')
	end

	def parsed_data
		@logs['fcst']
	end

	def speed_logs
		parsed_data['WINDSPD']
	end

	def gust_logs
		parsed_data['GUST']
	end

	def direction_logs
		parsed_data['WINDDIR']
	end

	def time_logs
		parsed_data['hr_h']
	end

	def current_hour
		Time.zone.now.hour
	end
end
