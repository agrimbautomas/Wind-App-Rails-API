RSpec.shared_context 'create user' do
	let!(:user) { create :user }
end

RSpec.shared_context 'create station' do
	let!(:station) { create :station }
end