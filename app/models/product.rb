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

class Product < ApplicationRecord
  has_many :order_products, dependent: :destroy
  has_many :informations, class_name: "ProductInformation", dependent: :destroy
  has_many :markets, through: :product_informations
  has_many :orders, through: :order_products
  belongs_to :category, optional: true
  
  def lang_name
    lang = I18n.locale.to_s
    lang == "ar" ? self['name'] : self["name_#{lang}"]
  end

  def get_price market_id
    item_price =  self.informations.find_by(market_id: market_id)
    item_price ? item_price.price : ''
  end
  def set_price market_id, val
    # Find or create the price for the current product
    product_price = self.informations.find_or_create_by(market_id: market_id)
    product_price.price = val
    product_price.save
  end
  def get_url market_id
    item_url =  self.informations.find_by(market_id: market_id)
    item_url ? item_url.market_url : ''
  end
  def set_url market_id, val
    # Find or create the price for the current product
    product_url = self.informations.find_or_create_by(market_id: market_id)
    product_url.market_url = val
    product_url.save
  end
  
end
