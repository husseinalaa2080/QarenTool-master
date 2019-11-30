# == Schema Information
#
# Table name: order_products
#
#  id         :bigint           not null, primary key
#  order_id   :bigint
#  product_id :bigint
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class OrderProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
