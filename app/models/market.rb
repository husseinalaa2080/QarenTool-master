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

class Market < ApplicationRecord
    has_many :informations, class_name: "ProductInformations"
    # has_many :products, -> { distinct },through: :prices

    default_scope { order("name#{'_en' if I18n.locale == 'en'}") }
    scope :active, -> { where(active: true) }

    def lang_name
        lang = I18n.locale.to_s
        lang == "ar" ? self['name'] : self["name_#{lang}"]
    end
end
