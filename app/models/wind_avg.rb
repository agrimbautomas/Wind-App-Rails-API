# == Schema Information
#
# Table name: wind_avgs
#
#  id              :bigint(8)        not null, primary key
#  speed           :float            not null
#  gust            :float
#  direction       :float            not null
#  registered_date :datetime
#

class WindAvg < ApplicationRecord

	validates_presence_of :speed, :direction, :registered_date

	before_save :round_values

	def round_values
		self.speed = self.speed.round(1) unless self.speed.nil?
		self.gust = self.gust.round(1) unless self.gust.nil?
		self.direction = self.direction.round(1) unless self.direction.nil?
	end

end
