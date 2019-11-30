class UserController < ApplicationController
    protect_from_forgery
    before_action :clear_empty_carts
    before_action :set_cart


    protected
    
    private

    def clear_empty_carts
        Order.empty_carts.destroy_all
    end

    def set_cart
        @cart = Order.find(session[:cart_id])
        rescue ActiveRecord::RecordNotFound
        @cart = Order.create
        session[:cart_id] = @cart.id
    end
end