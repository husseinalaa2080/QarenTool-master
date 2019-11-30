class AdminController < ApplicationController
    protect_from_forgery
    before_action :authenticate_admin!
    before_action :current_path

    private

    def current_path
        @current_path = request.path.split('/')
    end
end