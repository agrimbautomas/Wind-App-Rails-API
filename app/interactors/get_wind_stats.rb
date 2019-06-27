class GetWindStats < Interactor

	def self.default
		get_wind_stats = new
		get_wind_stats.execute
	end

	def initialize
	end

	def execute
		Station.find_by_slug('colonia').wind_logs.limit(3).order(registered_date: :desc)
	end

end
