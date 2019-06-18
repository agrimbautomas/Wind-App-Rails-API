# == Schema Information
#
# Table name: entries
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  status      :string(255)
#  site_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  released_at :datetime
#  email_sent  :boolean          default(FALSE)
#  featured    :boolean          default(FALSE)
#

FactoryBot.define do

	factory :entry do

		sequence(:title) { |n| "Some entry" }
		sequence (:site_id) { |n| 3442 }

		factory :entry_without_site_id do
			site_id { nil }
		end

	end

end
