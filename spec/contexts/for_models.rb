RSpec.shared_context 'create user' do
	let!(:user) { create :user }
end

RSpec.shared_context 'create station' do
	let!(:station) { create :station }
end
RSpec.shared_context 'create wind_log' do
	let!(:wind_log) { create :wind_log}
end