# == Schema Information
#
# Table name: wind_logs
#
#  id              :bigint(8)        not null, primary key
#  speed           :float            not null
#  gust            :float
#  direction       :float            not null
#  registered_date :datetime
#  station_id      :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_wind_logs_on_station_id  (station_id)
#

class WindLog < ApplicationRecord

	belongs_to :station
	validates_presence_of :speed, :direction, :registered_date


	def round_values
		self.speed = self.speed.round(1) unless self.speed.nil?
		self.gust = self.gust.round(1) unless self.gust.nil?
		self.direction = self.direction.round(1) unless self.direction.nil?
	end

	def self.forecasted_and_recorded
		logs = []


		self.recorded.each { |log| logs << log }

	end

	def self.recorded
		norden = Station.find_by_slug('norden')
		hours_before = Time.now - 8.hours

		latest_logs = self.where('station_id = ? AND registered_date > ?', norden, hours_before)
											.order('registered_date ASC')

		hour_logs = []

		latest_logs.each_with_index do |log, e|
			index = log.registered_date.hour

			(hour_logs[index] ||= []).push(log)
		end


		#hour_logs
		latest_logs
	end
end
