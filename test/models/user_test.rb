# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  name         :string
#  mobile       :string
#  email        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  visits_count :integer          default(1)
#  last_visit   :datetime
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
