# == Schema Information
#
# Table name: admin_settings
#
#  id                     :bigint           not null, primary key
#  allow_registration     :boolean          default(TRUE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  show_lowest_price      :boolean          default(FALSE)
#  show_saving_percentage :boolean          default(FALSE)
#  visit_timer            :decimal(7, 4)    default(6.0)
#

require 'test_helper'

class AdminSettingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
