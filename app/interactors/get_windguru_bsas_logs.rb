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

			store_wind_log(e) if log.to_i >= current_hour and log.to_i < current_hour + 4

			break if log.to_i > current_hour + 4
		end
	end

	def store_wind_log index
		speed = speed_logs[index].to_f.round(1)
		gust = gust_logs[index].to_f.round(1)
		direction = direction_logs[index]
		log_date = Time.zone.now.change(hour: time_logs[index].to_i)

		wind_log = WindLog.where(station: station, registered_date: log_date).first_or_initialize
		wind_log.speed = speed
		wind_log.gust = gust
		wind_log.direction = direction
		wind_log.save!
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
		Time.now.hour
	end
end
