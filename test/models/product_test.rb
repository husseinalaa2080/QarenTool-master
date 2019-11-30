# == Schema Information
#
# Table name: products
#
#  id            :bigint           not null, primary key
#  name          :string
#  name_en       :string
#  description   :text
#  main_image    :string
#  category_id   :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  lowest_price  :decimal(6, 2)
#  highest_price :decimal(6, 2)
#  basket_type   :integer
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
