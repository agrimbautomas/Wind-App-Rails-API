require 'rails_helper'
require 'contexts/for_models'

RSpec.shared_examples 'GetCarpStationLogs is succesful' do
	it 'request shows JSON response' do
		expect(response).to be_a Array
		expect(response.first['name']).to be_a String
	end
end

RSpec.describe GetCarpStationLogs do

	let(:response) {
		GetCarpStationLogs.default
	}

	context 'with correct params' do

		context 'with a valid endpoint URI' do
			include_examples 'GetCarpStationLogs is succesful'
		end

	end

end
