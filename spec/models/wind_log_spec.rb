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

require 'rails_helper'

RSpec.describe WindLog, type: :model do

  it { should respond_to(:speed) }
  it { should validate_presence_of(:speed) }

  it { should respond_to(:gust) }

	it { should respond_to(:direction) }
  it { should validate_presence_of(:direction) }

  it { should respond_to(:registered_date) }

  it { should respond_to(:station) }
  it { should belong_to(:station) }

end
