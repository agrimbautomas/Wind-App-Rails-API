require 'rails_helper'
require 'contexts/for_models'

RSpec.shared_examples 'GetWindStats is succesful' do
	it 'request shows JSON response' do
		expect(response).to be_a Array
		expect(response).not_to be_empty
		expect(response.count).to be < 6
	end
end

RSpec.describe GetWindStats do
	let!(:windguru) { create :station, :windguru}
	let!(:norden) { create :station, :norden}

	include_context 'create wind_avg'
	include_context 'create wind_avg'

	let(:response) {
		GetWindStats.serialized
	}

	context 'with correct params' do

		context 'with a records' do
			before{
				WindLog.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now + 2.hours, station: windguru)
				WindLog.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now + 1.hours, station: windguru)

				WindLog.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now, station: norden)
				WindLog.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now - 1.minutes, station: norden)
			}

			include_examples 'GetWindStats is succesful'
		end

		context 'with a valid endpoint URI' do
			before{
				WindLog.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now + 1.hours, station: windguru)
				WindLog.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now + 2.hours, station: windguru)
				WindLog.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now + 3.hours, station: windguru)
				WindLog.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now + 4.hours, station: windguru)

				WindLog.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now , station: norden)
				WindLog.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now - 1.minutes, station: norden)
				WindLog.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now - 2.minutes, station: norden)
				WindLog.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now - 3.minutes, station: norden)
				WindLog.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now - 4.minutes, station: norden)

				WindAvg.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now - 1.hours)
				WindAvg.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now - 2.hours)
				WindAvg.create(speed: 19.2, gust: 21.2, direction: 192.0, registered_date: Time.now - 3.hours)
			}

			include_examples 'GetWindStats is succesful'

		end

	end

end
