require 'rails_helper'
require 'contexts/for_models'

RSpec.shared_examples 'GetCarpData is succesful' do
	it 'request shows JSON response' do
		expect(response).to be_a Hash
	end
end

RSpec.shared_examples 'GetCarpData raise error' do
	it 'the interactor raises an error' do
		expect { response }.to raise_error Error
	end
end

RSpec.describe GetCarpData do

	let(:response) {
		GetCarpData.default
	}

	context 'with correct params' do

		context 'with a valid endpoint URI' do
			include_examples 'GetCarpData is succesful'
		end

	end

end
