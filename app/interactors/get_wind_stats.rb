class GetWindStats < Interactor
	include TimeHelper

	def self.serialized
		get_wind_stats = new
		get_wind_stats.execute
	end

	def initialize
	end

	def execute
		serialized_stats
	end

	def serialized_stats
		logs = []
		previous.each { |log| logs << log }
		logs << current
		upcoming.each { |log| logs << log }
		logs
	end

	def serialize_log log
		{
				id: log.id,
				speed: log.speed,
				gust: log.gust,
				direction: log.direction,
				hour: log.registered_date.hour,
				registered_date: log.registered_date
		}
	end

	def current

		latest_wind_log = Station.find_by_slug('norden').wind_logs.last
		if latest_wind_log.registered_date.hour < current_hour
			latest_wind_log = current_windguru_log unless current_windguru_log.nil?
		end
		serialize_log latest_wind_log
	end

	def windguru_upcomming_logs
		windguru_logs
				.where('registered_date > ?', Time.zone.now)
				.limit(2)
				.order('registered_date ASC')
	end

	def avg_logs
		WindAvg.all.limit(2).where('registered_date > ?', Time.now - 3.hours)
	end
	
	def previous
		logs_to_array avg_logs
	end
	
	def upcoming
		logs_to_array windguru_upcomming_logs
	end

	def logs_to_array wind_logs
		logs = []
		wind_logs.each { |log| logs << serialize_log(log) }
		logs
	end

	def current_windguru_log
		windguru_logs
				.where('registered_date >= ? AND registered_date < ? ', Time.now - 1.hour, Time.now)
				.first
	end

	def windguru_logs
		Station.find_by_slug('windguru').wind_logs
	end

end
