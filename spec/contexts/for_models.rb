RSpec.shared_context 'create user' do
	let!(:user) { create :user }
end

RSpec.shared_context 'create station' do
	let!(:station) { create :station }
end

RSpec.shared_context 'create norden' do
	let!(:station) { create :station, :norden }
end

RSpec.shared_context 'create colonia' do
	let!(:station) { create :station, :colonia }
end

RSpec.shared_context 'create windguru' do
	let!(:station) { create :station, :windguru}
end

RSpec.shared_context 'create wind_log' do
	let!(:wind_log) { create :wind_log}
end

RSpec.shared_context 'create wind_avg' do
	let!(:avg) { create :wind_avg}
end
