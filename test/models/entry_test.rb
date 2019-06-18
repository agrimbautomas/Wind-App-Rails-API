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

require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
