# == Schema Information
#
# Table name: product_informations
#
#  id         :bigint           not null, primary key
#  market_id  :bigint
#  product_id :bigint
#  price      :decimal(12, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductInformation < ApplicationRecord
  belongs_to :market
  belongs_to :product

  # default_scope { includes(:market) }
  scope :order_by_market_name, -> { joins(:market).order("markets.name#{ '_en' if I18n.locale == 'en' }") }
  
end
