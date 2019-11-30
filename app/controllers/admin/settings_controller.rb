class Admin::SettingsController < AdminController
    before_action :authenticate_role

    def index
    end

    def change_settings
        allow_registration = params[:allow_registration] == '0' ? false : true
        show_prices = params[:show_lowest_price] == '0' ? false : true
        show_percentage = params[:show_saving_percentage] == '0' ? false : true

        settings = AdminSetting.first;
        settings.allow_registration = allow_registration
        settings.show_lowest_price = show_prices
        settings.show_saving_percentage = show_percentage
        settings.visit_timer = params[:visit_timer]

        if settings.save
            redirect_to admin_settings_path, flash: {notice: 'Settings Updated Successfully'}
        else
            redirect_to admin_settings_path, flash: {alert: 'Sorry could not update settings'}
        end
    end

    private 
    
    def authenticate_role
        redirect_to admin_path, flash: { warning: 'You are not allowed' } if !current_admin.super_admin
    end
end
