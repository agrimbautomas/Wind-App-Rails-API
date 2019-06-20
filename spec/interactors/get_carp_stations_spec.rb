require 'rails_helper'
require 'contexts/for_models'

RSpec.shared_examples 'GetCarpStations is succesful' do
	it 'request shows JSON response' do
		expect(response).to be_a Array
		expect(response.first['name']).to be_a String
	end
end

RSpec.describe GetCarpStations do

	let(:response) {
		GetCarpStations.default
	}

	context 'with correct params' do

		context 'with a valid endpoint URI' do
			include_examples 'GetCarpStations is succesful'
		end

	end

end
