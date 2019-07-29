module StationsHelper

	def norden
		Station.find_by_slug('norden')
	end

	def windguru_logs
		Station.find_by_slug('windguru').wind_logs
	end

end
