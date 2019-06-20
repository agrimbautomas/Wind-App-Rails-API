class GetCarpNordenLogs < GetCarpData

	def execute
		super
		@logs["stations"]
	end

	def params
		# Norden config
		super + '&p=1&p1=2&p2=1&p3=1'
	end

end
