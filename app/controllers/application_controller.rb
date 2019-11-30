class ApplicationController < ActionController::Base
    protect_from_forgery

    before_action :set_locale
    before_action :set_instance_locale
    before_action :check_admin_settings
    
    private

    def or_en
        '_en' if I18n.locale.to_s == 'en'
    end

    def set_locale
        I18n.locale = params[:locale] #|| @lang || I18n.default_locale
    end
    
    def set_instance_locale
        @lang = I18n.locale.to_s
    end
    
    def default_url_options
        { locale: I18n.locale }
    end

    def check_admin_settings
        setting = AdminSetting.first
        if setting
            @allow_admin_registration = setting.allow_registration
            @show_lowest_price = setting.show_lowest_price
            @show_saving_percentage = setting.show_saving_percentage
            @visit_timer = setting.visit_timer
        end
    end
end
