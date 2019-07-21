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

require 'rails_helper'

RSpec.describe WindAvg, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
