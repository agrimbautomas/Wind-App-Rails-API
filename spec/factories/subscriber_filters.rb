# == Schema Information
#
# Table name: subscriber_filters
#
#  id            :bigint(8)        not null, primary key
#  subscriber_id :bigint(8)        not null
#  name          :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_subscriber_filters_on_subscriber_id  (subscriber_id)
#

FactoryBot.define do

	factory :subscriber_filter do

		sequence(:name) { |n| "A filter #{n}" }

		factory :subscriber_filter_without_name do
			name { nil }
		end

	end

end
