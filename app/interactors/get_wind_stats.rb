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
		latest = serialize_log Station.find_by_slug('norden').wind_logs.last

		per_hour = []

		WindLog.forecasted_and_recorded.each { |log| per_hour << serialize_log(log) }

		{
				:latest => latest,
				:per_hour => per_hour
		}
	end

	def serialize_log log
		{
				id: log.id,
				speed: log.speed,
				gust: log.gust,
				direction: log.direction,
				hour: log.registered_date.hour,
				registered_date: log.registered_date
		}
	end

end
