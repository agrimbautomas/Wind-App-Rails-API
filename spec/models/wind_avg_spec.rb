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

  it { should respond_to(:speed) }
  it { should validate_presence_of(:speed) }

  it { should respond_to(:gust) }

  it { should respond_to(:direction) }
  it { should validate_presence_of(:direction) }

  it { should respond_to(:registered_date) }

end
