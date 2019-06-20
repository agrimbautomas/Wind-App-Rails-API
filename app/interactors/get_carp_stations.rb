class GetCarpStations < GetCarpData

	def execute
		super
		@logs["stations"]
	end

end
