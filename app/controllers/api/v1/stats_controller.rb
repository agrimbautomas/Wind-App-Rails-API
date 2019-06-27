class Api::V1::StatsController < Api::V1::ApiController
	skip_before_action :verify_authenticity_token

	def index
		render_successful_wind_stats best_wind_logs
	end

	private

	def best_wind_logs
		GetWindStats.serialized
	end

end
