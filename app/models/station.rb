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

class Station < ApplicationRecord
	validates :name, presence: true, allow_blank: false,
			:uniqueness => { :case_sensitive => false }, length: { maximum: 255 }

	has_many :wind_logs

end
