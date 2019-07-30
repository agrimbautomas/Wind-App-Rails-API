module StationsHelper
	NORDEN_DEVIATION = 2

	def norden
		Station.find_by_slug('norden')
	end

	def windguru
		Station.find_by_slug('windguru')
	end

	def windguru_logs
		windguru.wind_logs
	end

end
