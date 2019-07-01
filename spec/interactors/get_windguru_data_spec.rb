require 'rails_helper'
require 'contexts/for_models'

RSpec.shared_examples 'GetWindguruData is succesful' do
	it 'request shows JSON response' do
		expect(response).to be_a Hash
		expect(response['fcst']).to be_a Hash
		expect(response['fcst']['WINDSPD']).to be_a Array
		expect(response['fcst']['GUST']).to be_a Array
		expect(response['fcst']['WINDDIR']).to be_a Array
		expect(response['fcst']['hr_h']).to be_a Array
	end
end

RSpec.shared_examples 'GetWindguruData raise error' do
	it 'the interactor raises an error' do
		expect { response }.to raise_error Error
	end
end

RSpec.describe GetWindguruData do

	let(:response) {
		GetWindguruData.default
	}

	context 'with correct params' do

		context 'with a valid endpoint URI' do
			include_examples 'GetWindguruData is succesful'
		end

	end

end
