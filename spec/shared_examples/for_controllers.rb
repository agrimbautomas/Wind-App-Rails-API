RSpec.shared_examples 'expect json content type' do |status|
	it { expect( response.content_type ).to eq( "application/json" ) }
	it { expect( response.status ).to eq status }
end

RSpec.shared_examples 'expect html content type' do |status|
	it { expect( response.content_type ).to eq( "text/html" ) }
	it { expect( response.status ).to eq status }
end


RSpec.shared_context 'get request' do
	before { get get_action, { params: params } }
end

RSpec.shared_context 'post request' do
	before { post post_action, { params: params } }
end

RSpec.shared_context 'patch request' do
	before { patch patch_action, { params: params } }
end

RSpec.shared_context 'delete request' do
	before { delete delete_action, { params: params } }
end

RSpec.shared_examples 'expect correct collection response' do
	let( :scope ) {}
	let( :response_serialization ) {
		ActiveModelSerializers::SerializableResource.new( response_collection )
	}
	include_examples 'expect correct response'
end

RSpec.shared_examples 'expect correct response' do
	it { expect(response.body).to eq({ response: response_serialization }.to_json )}
end

RSpec.shared_examples 'expect successful response' do
	include_examples 'expect json content type', 200
end

RSpec.shared_examples 'expect successful html response' do
	include_examples 'expect html content type', 200
end

RSpec.shared_examples 'expect bad request response' do
	include_examples 'expect json content type', 400
end

RSpec.shared_examples 'expect unauthorized response' do
	it { expect( response.status ).to eq 401 }
end

RSpec.shared_examples 'expect redirect response' do
	it { expect( response.status ).to eq 302 }
end

RSpec.shared_examples 'expect forbidden response' do
	include_examples 'expect json content type', 403
end

RSpec.shared_examples 'expect not found response' do
	include_examples 'expect json content type', 404
end

RSpec.shared_examples 'expect unprocessable entity response' do
	include_examples 'expect json content type', 422
end

RSpec.shared_examples 'expect correct error response' do
	it { expect(response.body).to eq({
		response: {
			error: error,
			error_message: error_message
		}
	}.to_json )}
end

RSpec.shared_examples 'expect empty successful response' do
	it { expect(response.body).to eq({
		response: {
			status: "successful"
		}
	}.to_json )}

	include_examples 'expect successful response'
end

RSpec.shared_examples 'post request creates a new record' do
	it 'creates a new record' do
		expect{ post_request }.to change{active_model_collection.count}.by(1)
	end
end


RSpec.shared_examples 'destroy objects endpoint examples' do
	describe '#destroy' do
		let(:delete_action ) { :destroy }
		let(:delete_objects_count) { object_ids.count }

		include_examples 'destroy endpoint with invalid token examples'
		include_examples 'destroy endpoint called with valid params examples'
	end
end

RSpec.shared_examples 'destroy object endpoint examples' do
	describe '#destroy' do
		let(:delete_action ) { :destroy }
		let(:params ) { { id: object_id } }
		let(:delete_objects_count) { 1 }

		include_examples 'destroy endpoint with invalid token examples'
		include_examples 'destroy endpoint called with valid params examples'
		include_examples 'destroy endpoint called with invalid params examples'
	end
end

RSpec.shared_examples 'destroy endpoint with invalid token examples' do
	context 'without token' do
		include_context 'delete request'
		include_examples 'expect unauthorized response'
	end
end

RSpec.shared_examples 'destroy endpoint called with valid params examples' do
	context 'with token' do
		include_context 'stub doorkeeper'

		context 'with correct params' do
			context do
				include_context 'delete request'
				include_examples 'expect empty successful response'
			end

			include_examples 'delete request destroys the object'
		end
	end
end

RSpec.shared_examples 'destroy endpoint called with invalid params examples' do
	context 'with token' do
		include_context 'stub doorkeeper'

		context 'with invalid object id' do
			let( :object_id ) { object_class.maximum( :id )&.next }
			let( :error ) { 'not_found' }
			let( :error_message ) { "Couldn't find #{object_class.name} with 'id'=#{object_id}" }

			include_context 'delete request'
			include_examples 'expect not found response'
			include_examples 'expect correct error response'
		end
	end
end

RSpec.shared_examples 'delete request destroys the object' do
	it 'destroy the object' do
		expect{ delete delete_action, { params: params } }.to change{object_class.count}.by(- delete_objects_count)
	end
end

RSpec.shared_examples 'expect example for role' do | role, request_context, expected_example |
	context "with a #{role} role" do 
		include_context 'stub member role', role
		include_context request_context
		include_examples expected_example
	end
end

RSpec.shared_examples 'expect successful response for roles' do | roles, request_context |
	roles.each do | role |
		include_examples 'expect example for role', role, request_context, 'expect successful response'
	end
end

RSpec.shared_examples 'expect unauthorized response for roles' do | roles, request_context |
	roles.each do | role |
		include_examples 'expect example for role', role, request_context, 'expect unauthorized response'
	end
end

RSpec.shared_examples 'expect unauthorized response without role' do  | request_context |
	context 'without role for the project' do
		include_context 'stub member role', nil
		include_context request_context
		include_examples 'expect unauthorized response'
	end
end
