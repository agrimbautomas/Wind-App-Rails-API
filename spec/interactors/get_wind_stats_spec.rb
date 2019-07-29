require 'rails_helper'
require 'contexts/for_models'

RSpec.shared_examples 'GetWindStats is succesful' do
  it 'request shows JSON response' do
    expect(response).to be_a Hash
    expect(response).not_to be_empty
    expect(response.count).to be < 6
  end
end

RSpec.describe GetWindStats do
  let!(:windguru) { create :station, :windguru }
  let!(:norden) { create :station, :norden }

  include_context 'create wind_avg'
  include_context 'create wind_avg'

  let(:response) {
    GetWindStats.serialized
  }

  context 'with correct params' do

    context 'with a few records' do
      before {
        WindLog.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now + 2.hours, station: windguru)
        WindLog.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now + 1.hours, station: windguru)

        WindLog.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now, station: norden)
        WindLog.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now - 1.minutes, station: norden)
      }

      include_examples 'GetWindStats is succesful'
    end

    context 'with a bigger amount of records' do
      before {
        # For current wind
        WindLog.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now, station: norden)

        # For upcoming and latests records
        for i in 1..10
          WindLog.create(speed: rand(1.0..40.0), gust: rand(1.0..40.0), direction: rand(0.0..360.0), registered_date: Time.now + i.hours, station: windguru)
          WindLog.create(speed: rand(1.0..40.0), gust: rand(1.0..40.0), direction: rand(0.0..360.0), registered_date: Time.now - i.minutes, station: norden)
          WindAvg.create(speed: rand(1.0..40.0), gust: rand(1.0..40.0), direction: rand(0.0..360.0), registered_date: Time.now - i.hours, source: 'norden')
        end
      }

      include_examples 'GetWindStats is succesful'

      it 'has a current log' do
        expect(response[:current]).to be_present
        expect(response[:current]).to be_a Hash
      end

      it 'matches current log hour with time' do
        expect(response[:current][:registered_date].hour).to be_in([Time.zone.now.hour, (Time.zone.now - 1.hour).hour])
      end

      it 'has a logs' do
        expect(response[:logs]).to be_present
        expect(response[:logs]).to be_a Array
      end

      it 'has 5 logs' do
        expect(response[:logs].count).to eq 5
      end


    end

  end

end
