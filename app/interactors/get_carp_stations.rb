class GetCarpStations < GetCarpData

	def execute
		super
		@logs["stations"]
	end

	# def parse_logs logs
	# 	Savelogs.save(logs: logs)
	# end

end
