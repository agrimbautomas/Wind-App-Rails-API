class UpdateStatsEvent < Interactor

	def self.with(stats:, event:)
		interactor = new(
				stats: stats,
				event: event
		)
		interactor.execute unless Rails.env.test?
	end

	def execute
		stats = GetWindStats.default
		Pusher.trigger('stats-channel', 'stats-changed', {
				stats: StatsSerializer.new(stats).to_json
		})
	end

end