class Admin::OrdersController < AdminController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    def index
        @orders = Order.proceeded.order('confirmed DESC, created_at DESC')

        if params[:customer_phone] && !params[:customer_phone].empty?
            user = User.where('mobile like ?', "%#{params[:customer_phone]}%").first
            @orders = user.orders if user
        end
        if params[:user_id] && !params[:user_id].empty?
            if User.find_by(id: params[:user_id])
                user = User.find(params[:user_id])
                @orders = user.orders
            else
                flash[:warning] = "No such user with the entered ID"
            end
        end
        @orders = @orders.where(confirmed: true) if params[:confirmation].to_i == 1
        @orders = @orders.where(confirmed: nil) if params[:confirmation].to_i == 2
        # @orders = @orders.joins(:user).where(user: {mobile: params[:customer_phone]}) if params[:customer_phone] && !params[:customer_phone].empty?
        @orders = @orders.page params[:page]
    end
    
    def show
        @order = Order.find(params[:id])
        @order_products = @order.order_products
        @counts = {
            product_count: @order_products.size,
            quantity_count: @order_products.sum { |item| item.quantity }
        }
        @markets = Market.active
    end

    def destroy
        order = Order.find(params[:id])
        order.destroy
        redirect_to admin_orders_path, flash: { notice: 'Order Deleted Successfully' }
    end

    def view_invoice
        @order = Order.find(params[:id])
        @order_products = @order.order_products
        @markets = Market.active
    end

    def generate_invoice
        order = Order.find(params[:id])
        msg = { notice: 'Invoice generated successfully' }
        
        if order.user_id
            order.confirmed = true
            order.confirmed_by = params[:admin]
            order.confirmed_at = DateTime.now
            # raise ''
            order.save
        else
            msg = { alert: 'Cannot generate invoice on unprocessed Cart' }
        end

        redirect_to admin_invoice_path(order), flash: msg
    end

    def record_not_found
        flash[:warning] = "Record Not Found"
        redirect_to :back
    end
    
end
