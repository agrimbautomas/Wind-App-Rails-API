require 'rails_helper'
require 'contexts/for_models'

RSpec.shared_examples 'GetCarpStationLogs raise error' do
	it 'the interactor raises an error' do
		expect { response }.to raise_error Error
	end
end

RSpec.describe GetCarpStationLogs do

	include_context 'create wind_log'

	let(:response) {
		GetCarpStationLogs.default
	}

	context 'with correct params' do

		context 'with a valid endpoint URI' do
			#include_examples  'GetCarpData raise error'
		end

	end

end
