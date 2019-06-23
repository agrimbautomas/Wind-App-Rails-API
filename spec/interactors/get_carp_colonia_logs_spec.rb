require 'rails_helper'
require 'contexts/for_models'


RSpec.shared_examples 'GetCarpColoniaLogs is succesful' do
	it 'request shows JSON response' do
		expect(response).to be_a Hash
	end
end

RSpec.shared_examples 'GetCarpColoniaLogs creates new wind logs' do
	it do
		expect(station.wind_logs.count).to be > 0
	end
end

RSpec.describe GetCarpColoniaLogs do

	include_context 'create colonia'

	let(:response) {
		GetCarpColoniaLogs.default
	}

	context 'with correct params' do

		context 'with a valid endpoint URI' do
			include_examples 'GetCarpColoniaLogs is succesful'
		end

		context 'with a valid endpoint URI' do
			before { GetCarpColoniaLogs.default }
			include_examples 'GetCarpColoniaLogs creates new wind logs'
		end

	end

end
