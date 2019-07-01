require 'rails_helper'
require 'contexts/for_models'

RSpec.shared_examples 'GetWindguruBsasLogs is succesful' do
	it 'request shows JSON response' do
		expect(response['fcst']).to be_a Hash
		expect(response['fcst']['WINDSPD']).to be_a Array
		expect(response['fcst']['GUST']).to be_a Array
		expect(response['fcst']['WINDDIR']).to be_a Array
		expect(response['fcst']['hr_h']).to be_a Array
	end
end

RSpec.describe GetWindguruBsasLogs do

	include_context 'create windguru'

	let(:response) {
		GetWindguruBsasLogs.default
	}

	context 'with correct params' do

		context 'with a valid endpoint URI' do
			include_examples 'GetWindguruBsasLogs is succesful'
		end

	end

end
