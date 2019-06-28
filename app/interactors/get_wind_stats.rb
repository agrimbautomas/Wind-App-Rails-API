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
		{
				:latest => Station.find_by_slug('norden').wind_logs.last,
				:per_hour => Station.find_by_slug('norden').wind_logs.last
		}
	end
end
