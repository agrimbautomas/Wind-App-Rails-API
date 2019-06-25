class Api::V1::StatsController < Api::V1::ApiController
	skip_before_action :verify_authenticity_token

	def index
		render_successful_response best_wind_logs, StatsSerializer
	end

	private

	def best_wind_logs
		Station.find_by_slug('norden').wind_logs.limit(3).order(registered_date: :desc)
	end

	#
	# def latest_wind_logs
	# 	[
	# 			norden: norden_wind_logs,
	# 			colonia: colonia_wind_logs
	# 	]
	# end

		# def colonia_wind_logs
	# 	Station.find_by_slug('colonia').wind_logs.limit(3)
	# end

end
