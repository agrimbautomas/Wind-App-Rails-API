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
require 'contexts/for_models'

RSpec.shared_examples 'creation is valid' do
  it 'creation is valid' do
    expect(create_wind_log).to be_valid
  end
end

RSpec.shared_examples 'creation is invalid' do
  it 'creation is invalid' do
    expect(create_wind_log).not_to be_valid
  end
end

RSpec.describe WindLog, type: :model do

  it { should respond_to(:speed) }
  it { should validate_presence_of(:speed) }

  it { should respond_to(:gust) }

	it { should respond_to(:direction) }
  it { should validate_presence_of(:direction) }

  it { should respond_to(:registered_date) }
	it { should validate_presence_of(:registered_date) }
	
  it { should respond_to(:station) }
  it { should belong_to(:station) }

  let(:create_wind_log) {
    WindLog.create(
        speed: speed,
        gust: gust,
        direction: direction,
        station: station,
        registered_date: registered_date
    )
  }

  describe '#create' do
    include_context 'create norden'
    let(:speed) { 10.2 }
    let(:gust) { 14.1 }
    let(:direction) { 108.6 }
    let(:registered_date) { Time.now }

    context 'with all parameters' do

			include_examples 'creation is valid'


      it 'set the share_hash' do
        valid_wind_log = create_wind_log
        expect(valid_wind_log).to be_valid
      end
    end

    context 'without the optional parameters' do
      let(:gust) { nil }
      include_examples 'creation is valid'
    end

    context 'without speed' do
      let(:speed) { nil }
      include_examples 'creation is invalid'
    end

    context 'without direction' do
      let(:direction) { nil }
      include_examples 'creation is invalid'
    end

    context 'without registered_date' do
      let(:registered_date) { nil }
      include_examples 'creation is invalid'
		end

    context 'with large float speed' do
      let(:speed) { 17.44444444444 }
      it 'round float number' do
        expect(create_wind_log.speed).to eq(17.4)
      end
    end

    context 'with large float gust' do
      let(:gust) { 3.2222221 }
      it 'round float number' do
        expect(create_wind_log.gust).to eq(3.2)
      end
		end

    context 'with large float direction' do
      let(:direction) { 181.9999 }
      it 'round float number' do
        expect(create_wind_log.direction).to eq(182.0)
      end
    end

  end

end
