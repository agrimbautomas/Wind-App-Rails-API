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

FactoryBot.define do
  factory :wind_avg do
    sequence(:speed) { rand(0.0..40.0) }
    sequence(:gust) { rand(0.0..40.0) }
    sequence(:direction) { rand(0.0..360.0) }
    sequence(:registered_date) { Time.zone.now }
  end
end
