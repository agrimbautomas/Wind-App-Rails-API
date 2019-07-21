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

	belongs_to :station
	validates_presence_of :speed, :direction
	
end
