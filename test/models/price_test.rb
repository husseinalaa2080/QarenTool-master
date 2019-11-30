# == Schema Information
#
# Table name: prices
#
#  id         :bigint           not null, primary key
#  market_id  :bigint
#  product_id :bigint
#  price      :decimal(12, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class PriceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
