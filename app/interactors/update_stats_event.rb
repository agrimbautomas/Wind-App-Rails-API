class UpdateStatsEvent < Interactor

	def self.default
		interactor = new
		interactor.execute unless Rails.env.test?
	end

	def initialize
	end

	def execute
		Pusher.trigger('stats-channel', 'stats-changed', {
				stats: GetWindStats.serialized
		})
	end

end