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

class Order < ApplicationRecord
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
  belongs_to :user, optional: true
  belongs_to :admin, foreign_key: :confirmed_by, optional: true

  # before_create :clear_empty_carts
  
  default_scope { includes(:order_products, :products, :user, :admin) }
  scope :proceeded, -> { where.not(user_id: nil) }
  scope :filled_carts, -> { where(user_id: nil).where('EXISTS(SELECT 1 FROM order_products WHERE order_id = orders.id)') }
  scope :empty_carts, -> { where(user_id: nil).where('NOT EXISTS(SELECT 1 FROM order_products WHERE order_id = orders.id)') }
  scope :not_confirmed, -> { where(confirmed: false) }
  scope :confirmed, -> { where(confirmed: true) }


  def self.get_report(interval)
    if interval == 'daily'
      format = 'Mon-dd-YYYY'
    elsif interval == 'monthly'
      format = 'Mon'
    elsif interval == 'YYYY'
      format = '%Y'
    end
    report = {}
    o_kind = Order.select("orders.id,max(order_price) as max_price,min(order_price) as min_price,
    orders.user_id,orders.confirmed_by,to_char(created_at, '#{format}') as comee, avg(order_price) as average_order_price,
    count(orders.id) as purchase")
    .group("to_char(created_at, '#{format}'),orders.id")
    report["count"] = o_kind.collect(&:purchase)
    report["average_order_price"] = o_kind.collect(&:average_order_price)
    report["max_price"] = o_kind.collect(&:max_price)
    report["min_price"] = o_kind.collect(&:min_price)

    report["o_time"] =  o_kind.collect(&:comee)
    report 
  end


  

  private

  def clear_empty_carts
    Order.empty_carts.destroy_all
  end
end
