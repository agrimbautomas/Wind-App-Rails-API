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

require 'rails_helper'


RSpec.shared_examples 'avg creation is valid' do
	it 'avg creation is valid' do
		expect(create_wind_avg).to be_valid
	end
end

RSpec.shared_examples 'avg creation is invalid' do
	# noinspection RubyInterpreter
	it 'avg creation is invalid' do
		expect(create_wind_avg).not_to be_valid
	end
end

RSpec.describe WindAvg, type: :model do

	it { should respond_to(:speed) }
	it { should validate_presence_of(:speed) }

	it { should respond_to(:gust) }

	it { should respond_to(:direction) }
	it { should validate_presence_of(:direction) }

	it { should respond_to(:registered_date) }
	it { should validate_presence_of(:registered_date) }


	let(:create_wind_avg) {
		WindAvg.create(
				speed: speed,
				gust: gust,
				direction: direction,
				registered_date: registered_date,
				source: 'norden',
		)
	}

	describe '#create' do
		let(:speed) { 10.2 }
		let(:gust) { 14.1 }
		let(:direction) { 108.6 }
		let(:registered_date) { Time.now }

		context 'with all parameters' do
			include_examples 'avg creation is valid'

			it 'set the share_hash' do
				valid_wind_avg = create_wind_avg
				expect(valid_wind_avg).to be_valid
			end
		end

		context 'without the optional parameters' do
			let(:gust) { nil }
			include_examples 'avg creation is valid'
		end

		context 'without speed' do
			let(:speed) { nil }
			include_examples 'avg creation is invalid'
		end

		context 'without direction' do
			let(:direction) { nil }
			include_examples 'avg creation is invalid'
		end

		context 'without registered_date' do
			let(:registered_date) { nil }
			include_examples 'avg creation is invalid'
		end

		context 'with large float speed' do
			let(:speed) { 17.44444444444 }
			it 'round float number' do
				expect(create_wind_avg.speed).to eq(17.4)
			end
		end

		context 'with large float gust' do
			let(:gust) { 3.2222221 }
			it 'round float number' do
				expect(create_wind_avg.gust).to eq(3.2)
			end
		end

		context 'with large float direction' do
			let(:direction) { 181.9999 }
			it 'round float number' do
				expect(create_wind_avg.direction).to eq(182.0)
			end
		end
		
	end

end
