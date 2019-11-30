# == Schema Information
#
# Table name: categories
#
#  id           :bigint           not null, primary key
#  icon         :string
#  name         :string
#  name_en      :string
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  name_in_file :string
#

class Category < ApplicationRecord
    has_many :products, dependent: :destroy

    def lang_name
        lang = I18n.locale.to_s
        lang == "ar" ? self['name'] : self["name_#{lang}"]
    end
end
