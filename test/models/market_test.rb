# == Schema Information
#
# Table name: markets
#
#  id          :bigint           not null, primary key
#  name        :string
#  name_en     :string
#  description :text
#  logo        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  active      :boolean          default(TRUE)
#  sheet_name  :string
#

require 'test_helper'

class MarketTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
