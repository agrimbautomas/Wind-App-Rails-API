class GetWindStats < Interactor

	def self.serialized
		get_wind_stats = new
		get_wind_stats.execute
	end

	def initialize
	end

	def execute
		serialized_stats
	end

	def serialized_stats
		logs = []
		previous.each { |log| logs << log }
		logs << current
		upcoming.each { |log| logs << log }
		logs
	end

	def serialize_log log
		{
				speed: log.speed,
				gust: log.gust,
				direction: log.direction,
				hour: log.registered_date.hour,
				registered_date: log.registered_date
		}
	end

	def current
		serialize_log Station.find_by_slug('norden').wind_logs.last
	end

	def windguru_logs
		Station.find_by_slug('windguru').wind_logs
				.where('registered_date > ?', Time.zone.now)
				.limit(2)
				.order('registered_date ASC')
	end

	def avg_logs
		WindAvg.all.limit(2).where('registered_date > ?', Time.now - 3.hours)
	end
	
	def previous
		logs_to_array avg_logs
	end
	
	def upcoming
		logs_to_array windguru_logs
	end

	def logs_to_array wind_logs
		logs = []
		wind_logs.each { |log| logs << serialize_log(log) }
		logs
	end

end
