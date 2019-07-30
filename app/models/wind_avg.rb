# == Schema Information
#
# Table name: wind_avgs
#
#  id              :bigint(8)        not null, primary key
#  speed           :float            not null
#  gust            :float
#  direction       :float            not null
#  registered_date :datetime
#  source          :string
#

class WindAvg < ApplicationRecord
  include StationsHelper

  validates_presence_of :speed, :direction, :registered_date, :source
  validates :speed, uniqueness: {scope: :registered_date}

  before_save :round_values

  def round_values
    self.speed = self.speed.round(1) unless self.speed.nil?
    self.gust = self.gust.round(1) unless self.gust.nil?
    self.direction = self.direction.round(1) unless self.direction.nil?
  end

  def speed_modified
    if source == 'norden' and speed > NORDEN_DEVIATION
      speed - NORDEN_DEVIATION
    else
      speed
    end
  end

  def gust_modified
    # Take speed as params since gust cannot be lower than speed
    if source == 'norden' and speed > NORDEN_DEVIATION
      gust - NORDEN_DEVIATION
    else
      gust
    end
  end

end
