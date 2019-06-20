require 'rails_helper'
require 'contexts/for_models'

RSpec.shared_examples 'PostRequest is succesful' do
	it 'request shows response' do
		expect(response).to be_a String
	end
end

RSpec.shared_examples 'PostRequest raise error' do
	it 'the interactor raises an error' do
		expect { response }.to raise_error Error
	end
end

RSpec.describe PostRequest do

	let(:uri) { URI.parse(Settings.scraped_url) + 'ecsCommand.php' }
	let(:params) { '' }
	let(:headers) { { 'Content-Type' => 'application/x-www-form-urlencoded' } }

	let(:response) {
		PostRequest.to(uri: uri, params: params, headers: headers)
	}

	context 'with correct params' do

		context 'with a valid endpoint URI' do
			include_examples 'PostRequest is succesful'
		end

		context 'with an empty URI' do
			let(:uri) { '' }
			include_examples 'PostRequest raise error'
		end

		context 'with a nil URI' do
			let(:uri) { nil }
			include_examples 'PostRequest raise error'
		end

		context 'with a invalid headers' do
			let(:headers) { nil }
			include_examples 'PostRequest raise error'
		end

		context 'with a invalid header format' do
			let(:headers) {  'Content-Type: application/x-www-form-urlencoded' }
			include_examples 'PostRequest raise error'
		end

	end

end
