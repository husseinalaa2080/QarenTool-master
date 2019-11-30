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
require 'uri'
class User < ApplicationRecord
    has_many :orders, dependent: :destroy
    # validates :mobile, presence: true , format: { with: /\A[0-9]{9}\z/, on: :create }
    # validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "only allows valid emails" }

    default_scope { includes(:orders) }
end
