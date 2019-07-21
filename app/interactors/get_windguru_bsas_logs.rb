class GetWindguruBsasLogs < GetWindguruData

	AMOUNT_OF_LOGS = 4

	def execute
		super
		save_logs
		UpdateStatsEvent.default
		@logs
	end

	private

	def save_logs
		@stored = 0

		time_logs.each_with_index do |log, i|

			store_wind_log(i) if log_is_recordable? log, i

			break if @stored == AMOUNT_OF_LOGS
		end
	end

	def store_wind_log index
		speed = speed_logs[index].to_f.round(1)
		gust = gust_logs[index].to_f.round(1)
		direction = direction_logs[index]
		log_date = Time.zone.now.change(hour: time_logs[index].to_i, day: day_logs[index].to_i)

		create_or_update_wind_log speed, gust, direction, log_date
	end

	def create_or_update_wind_log speed, gust, direction, log_date
		wind_log = WindLog.where(station: station, registered_date: log_date).first_or_initialize
		wind_log.speed = speed
		wind_log.gust = gust
		wind_log.direction = direction
		wind_log.save!

		@stored += 1
	end

	def log_is_from_today? index
		day_logs[index].to_i == current_day
	end

	def log_is_from_tomorrow? index
		day_logs[index].to_i == current_day + 1
	end

	def log_is_in_hour_range? log
		log.to_i >= current_hour
	end

	def log_is_recordable? log, i
		(log_is_from_today?(i) and log_is_in_hour_range?(log)) or log_is_from_tomorrow?(i)
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

	def day_logs
		parsed_data['hr_d']
	end

	def current_hour
		Time.now.hour
	end

	def current_day
		Time.now.day
	end

end
