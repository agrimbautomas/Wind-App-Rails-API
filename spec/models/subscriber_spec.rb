# == Schema Information
#
# Table name: subscribers
#
#  id         :bigint(8)        not null, primary key
#  email      :string(255)
#  available  :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)      not null
#
# Indexes
#
#  index_subscribers_on_email  (email)
#

require 'rails_helper'

RSpec.describe Subscriber, type: :model do

  it { should respond_to(:name) }

  it { should respond_to(:email) }
  it { should validate_presence_of(:email) }
  it { should validate_length_of(:email).is_at_most(255) }

  it { should respond_to(:filters) }
  it { should have_many(:filters) }

  describe '#create!' do
    context 'with correct params' do

      let(:valid_subscriber) { create(:subscriber) }
      it { expect(valid_subscriber).to be_valid }

    end

    context 'without name' do
      let(:subscriber_with_empty_name ) { create(:subscriber_with_empty_name ) }
      it { expect(subscriber_with_empty_name ).to be_valid }
    end

    context 'without email' do
      let(:invalid_subscriber) { create(:subscriber_without_email) }
      it { expect { invalid_subscriber }.to raise_exception(ActiveRecord::RecordInvalid) }
    end

  end
end
