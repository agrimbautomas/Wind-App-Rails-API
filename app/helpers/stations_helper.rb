module StationsHelper

	def windguru_logs
		Station.find_by_slug('windguru').wind_logs
	end

end
