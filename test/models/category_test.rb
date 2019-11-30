# == Schema Information
#
# Table name: categories
#
#  id           :bigint           not null, primary key
#  icon         :string
#  name         :string
#  name_en      :string
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  name_in_file :string
#

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
