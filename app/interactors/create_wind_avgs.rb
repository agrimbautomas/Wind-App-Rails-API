class CreateWindAvgs < Interactor

	def self.default
		scrape_wind_data = new
		scrape_wind_data.execute
	end

	def initialize

	end

	def execute
		get_last_hour_avg

	end

	private


	def get_last_hour_avg
		norden = Station.find_by_slug('norden')
		hours_before_min = (DateTime.now - 4.hours).change({ min: 0 })
		hours_before_max = (DateTime.now - 3.hours).change({ min: 0 })
		wind_logs = WindLog.where('station_id = ? AND registered_date > ? AND registered_date < ?',
				norden, hours_before_min, hours_before_max)

		speed_avg = wind_logs.average(:speed).to_f
		gust_avg = wind_logs.average(:gust).to_f
		direction_avg = wind_logs.average(:direction).to_f

		save_avg speed_avg, gust_avg, direction_avg, hours_before_min
	end

	def save_avg speed, gust, direction, date
		WindAvg.create!(speed: speed, gust: gust, direction: direction, registered_date: date)
	end

end
