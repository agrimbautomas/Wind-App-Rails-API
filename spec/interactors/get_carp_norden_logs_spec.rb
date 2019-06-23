require 'rails_helper'
require 'contexts/for_models'


RSpec.shared_examples 'GetCarpNordenLogs is succesful' do
	it 'request shows JSON response' do
		expect(response).to be_a Hash
	end
end

RSpec.shared_examples 'GetCarpNordenLogs creates new wind logs' do
	it do
		expect(station.wind_logs.count).to be > 0
	end
end

RSpec.describe GetCarpNordenLogs do

	include_context 'create norden'

	let(:response) {
		GetCarpNordenLogs.default
	}

	context 'with correct params' do

		context 'with a valid endpoint URI' do
			include_examples 'GetCarpNordenLogs is succesful'
		end

		context 'with a valid endpoint URI' do
			before { GetCarpNordenLogs.default }
			#include_examples 'GetCarpNordenLogs creates new wind logs'
		end

	end

end
