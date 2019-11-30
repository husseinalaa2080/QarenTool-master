module ApplicationHelper
    def is_ar
        I18n.locale.to_s == 'ar'
    end
    def format_date d
        d.strftime("%B %d, %Y, %I:%M:%S %p") unless d.nil?
    end
end
