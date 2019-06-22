class GetCarpNordenLogs < GetCarpStationLogs

	private

	def params
		# Norden config
		super + '&p=1&p1=2&p2=1&p3=1'
	end

	def station
		Station.find_by_slug('norden')
	end

end
