# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do

  it { should respond_to(:email) }
  it { should validate_presence_of(:email) }

  describe 'create user' do
    let(:create_user) { User.create email: 'valid@app.com', password: 'password' }

    context 'with correct email and password' do
      it 'the creation is valid' do
        expect{create_user}.to change{User.count}.by (1)
      end
		end

    context 'with incorrect email' do
      it 'the creation is invalid' do
        expect(
            User.create email: 'invalid-app.com', password: 'password'
        ).not_to be_valid
      end
    end

    context 'with incorrect password' do
      it 'the creation is invalid' do
        expect(
            User.create email: 'valid@app.com', password: nil
        ).not_to be_valid
      end
    end
  end

end
