class GetCarpColoniaLogs < GetCarpStationLogs

	private

	def params
		# Colonia config
		super + '&p=2&p1=1&p2=1&p3=1'
	end

	def station
		Station.find_by_slug('colonia')
	end

end
