# == Schema Information
#
# Table name: orders
#
#  id                  :bigint           not null, primary key
#  user_id             :bigint
#  order_price         :decimal(10, 2)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  confirmed           :boolean
#  confirmed_by        :integer
#  checkout_at         :datetime
#  confirmed_at        :datetime
#  max_total_price     :decimal(10, 2)
#  min_total_price     :decimal(10, 2)
#  max_market_id       :integer
#  min_market_id       :integer
#  average_total_price :decimal(10, 2)
#

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
