class User::PagesController < UserController
  # before_action :set_cart
  require "wicked_pdf"
  # Main landing page
  def home
    # raise ''
    @categories = Category.all.order("name#{or_en}").includes('products')
    # @top_products = Product.all.sample(10)
    # raise ''


    category_filter = params[:category]
    @search_term = params[:term]

    # Filter products with category or search term
    @products = Product.all
    @products = @products.where(category_id: category_filter) if category_filter
    @products = @products.where("name#{or_en} ILIKE ?", "%#{@search_term}%") if @search_term

    @products = @products.order("name#{or_en}").page params[:page]
    @products_count = @cart.order_products.size
  end

  # Add to cart action
  def add_to_cart
    @current_product = @cart.order_products.find_by(product_id: params[:order_product][:product_id])
    if @current_product
      @current_product.quantity += params[:order_product][:quantity].to_i
      @current_product.save
    else
      @current_product = @cart.order_products.create(product_params)
    end
    @products_count = @cart.order_products.size

    respond_to do |format|
      format.js
    end
  end
  
  # Remove from cart action
  def remove_from_cart
    @current_product = @cart.order_products.find(params[:id])
    @current_product.destroy
    @products_count = @cart.order_products.count
    
    respond_to do |format|
      format.js
    end
  end

  def increment_quantity
    @item = @cart.order_products.find(params[:item_id])
    @item.quantity += 1
    @item.save

    respond_to do |format|
      format.js
    end
  end
  
  def decrement_quantity
    @item = @cart.order_products.find(params[:item_id])
    @item.quantity -= 1 if @item.quantity > 1
    @item.save

    respond_to do |format|
      format.js
    end
  end

  def checkout
    # Get params
    name = params[:user_name]
    # phone = params[:user_phone]
    # email = params[:user_email]

    # # Remove 0 or +966 from phone number
    # phone = phone[1..phone.length] if phone.starts_with? "0"
    # phone = phone[4..phone.length] if phone.starts_with? "+"

    # Successful message
    msg = { notice: t("messages.checkedout") }
    validated = true

    # Validate Phone and email
    # if !User.find_or_create_by(mobile: phone).valid?
    #   msg = { alert: t("errors.invalid_phone") }
    #   validated = false
    # end

    # Validate Order
    if @cart.order_products.size == 0
      msg = { alert: t("errors.empty_cart") }
      validated = false
    end

    # Update  user if exists, or create one
    if validated
      user = User.find_or_create_by(id: session[:user_id])
      #user = User.find_or_create_by(mobile: phone)
      #user.email = email
      user.name = name if !name.empty?
      user.save
      # Attach order to user
      @cart.user_id = user.id
      @cart.checkout_at = DateTime.now
      @cart.save
      # Clear cart session
      session.delete(:cart_id)
      if @cart.save == true

        redirect_to controller: 'pages', action: 'generate_invoice', id: @cart.id , format: :pdf and return
      end  
    end
    redirect_to home_path, flash: msg
  end



  def generate_invoice

    @order   = Order.find(params[:id])
    @order_products = @order.order_products
    @markets = Market.active
    @counts = {
            product_count: @order_products.size,
            quantity_count: @order_products.sum { |item| item.quantity }
        }

      respond_to do  |format|
        format.pdf { 
          render template: 'user/pages/view_invoice',
          pdf: 'invoice',
          dpi: 1000,
          layout: 'pdf.html',
          encoding:"UTF-8", 
          disposition: 'attachment'}
        format.html
      end 
  end   

  def set_user
    if(session[:user_id] && !session[:user_id].empty?)
      @user = User.find(session[:user_id])
    elsif(params[:user_id] && !params[:user_id].empty?)
      @user = User.find_or_create_by(id: params[:user_id])
    else
      @user = User.create
    end
    if(((Time.now - @user.last_visit) / 1.hour).round(4) >= @visit_timer)
      @user.increment!(:visits_count, 1)
      @user.update(last_visit: DateTime.now)
    end
    session[:user_id] = @user.id

    respond_to do |format|
      format.json { render json: @user.id }
    end
  end

  # Case of unmatched route 
  def no_match
    redirect_to({ action: "home" }, flash: { alert: t("errors.routes.no_match") })
  end


  private

  def product_params
    params.require(:order_product).permit(:quantity, :product_id)
  end
end
