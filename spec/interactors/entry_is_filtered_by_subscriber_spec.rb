require 'rails_helper'
require 'contexts/for_models'

RSpec.shared_examples 'EntryIsFilteredBySubscriber is succesful with match' do
	it 'the entry is filtered by the tags' do
		expect(filtered_result).to be true
	end
end

RSpec.shared_examples 'EntryIsFilteredBySubscriber is succesful without match' do
	it 'the entry is filtered by the tags' do
		expect(filtered_result).to be false
	end
end

RSpec.shared_examples 'EntryIsFilteredBySubscriber raise error' do |error|
	it { expect (filtered_result).to raise_exception error }
end

RSpec.describe EntryIsFilteredBySubscriber do

	include_context 'create subscriber'

	let(:entry) { Entry.create!(title: 'El Candidado, Moldavsky 2019', site_id: 4355) }

	let(:filtered_result) {
		EntryIsFilteredBySubscriber.for(entry: entry, subscriber: subscriber)
	}

	context 'with correct params' do

		context 'with matching filters params' do
			before {
				subscriber.filters.create!(:name => 'Moldavsky')
				subscriber.filters.create!(:name => 'lechuga')
			}

			include_examples 'EntryIsFilteredBySubscriber is succesful with match'
		end

		context 'with NOT matching filters params' do
			before {
				subscriber.filters.create!(:name => 'some')
				subscriber.filters.create!(:name => 'flan')
			}
			include_examples 'EntryIsFilteredBySubscriber is succesful without match'
		end
	end

end
