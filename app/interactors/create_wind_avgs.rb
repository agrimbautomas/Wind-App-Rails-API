class CreateWindAvgs < Interactor

	def self.default
		scrape_wind_data = new
		scrape_wind_data.execute
	end

	def initialize

	end

	def execute
		get_avg_by_hour 3
		get_avg_by_hour 2
		get_avg_by_hour 1
	end

	private


	def get_avg_by_hour previos_hours
		@hours_before_min = rounded_time previos_hours
		@hours_before_max = rounded_time(previos_hours - 1)

		speed_avg = avg_by(:speed)
		gust_avg = wind_logs.average(:gust).to_f
		direction_avg = wind_logs.average(:direction).to_f

		save_avg speed_avg, gust_avg, direction_avg, @hours_before_min
	end

	def save_avg speed, gust, direction, date
		WindAvg.create!(speed: speed, gust: gust, direction: direction, registered_date: date) unless WindAvg.exists?(registered_date: date)
	end

	def rounded_time previos_hours
		(DateTime.now.in_time_zone - previos_hours.hours).change({ min: 0 })
	end

	def wind_logs
		WindLog.where('station_id = ? AND registered_date > ? AND registered_date < ?', station, @hours_before_min, @hours_before_max)
	end

	def avg_by column
		wind_logs.average(column).to_f
	end

	def station
		Station.find_by_slug('norden')
	end
end
