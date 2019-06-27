class GetWindStats < Interactor

	def execute
		Station.find_by_slug('colonia').wind_logs.limit(3).order(registered_date: :desc)
	end

end
