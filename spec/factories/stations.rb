# == Schema Information
#
# Table name: stations
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string           not null
#

FactoryBot.define do
  factory :station do
    sequence(:name) { |n| "Station #{n}" }
    sequence(:slug) { |n| "statition#{n}" }
  end
end
