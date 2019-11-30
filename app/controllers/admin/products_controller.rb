class Admin::ProductsController < AdminController
  require 'csv'
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    @products = @products.where(category_id: params[:category_id]) if params[:category_id] && !params[:category_id].empty?
    @products = @products.where('name ilike ?', "%#{params[:product_name]}%") if params[:product_name] && !params[:product_name].empty?
    @products = @products.order("name#{or_en}").page params[:page]
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @markets = Market.all.order('active DESC, name')
  end

  # GET /products/new
  def new
    @product = Product.new
    @markets = Market.all.order('active DESC, name')
  end

  # GET /products/1/edit
  def edit
    @markets = Market.all.order('active DESC, name')
  end

  # GET /products/new-upload
  def new_upload
  end

  # POST /products/upload_products
  def upload_products
    file = params[:sheet]
    msg = {}
    begin
      CSV.foreach(file.path, headers: true) do |row|
        # begin
          status = {
            success: true,
            alert: 'notice',
            msg: "Successfully uploaded products"
          }
          # Get product if exists by ID or Name
          if row['id'] && !row['id'].empty?
            product = Product.find_or_create_by(id: row['id'])
          # Or by name if exists
          elsif row['name'] && !row['name'].empty?
            product = Product.find_or_create_by(name: row['name'])
            product.name_en = row['name_en'] ? row['name_en'] : row['name']
          else
            # Or create a new one without name
            product = Product.new
            product.name = 'لم يتم العثور على اسم'
            product.name_en = 'No name found'
            status[:alert] = 'warning'
            status[:msg] += 'لم يتم ايجاد اسم لبعض المنتجات.'
          end
          
          # Set image
          product.main_image = row['img'] if row['img']
          
          lowest = 0
          highest = 0
          # Set prices for each market
          Market.all.each_with_index do |market, i|
            sheet_name = market.sheet_name
            url_column = market.sheet_url_name
            if row[sheet_name]
              price = row[sheet_name].to_f
            else
              price = 0.to_f
              status[:alert] = 'warning'
              status[:msg] += ' لم يتم ايجاد اسعار بعض المنتجات، قد يكون السبب اختلاف التسمية. '
            end
            if row[url_column]
              url = row[url_column]
            else
              url = nil
              status[:alert] = 'warning'
              status[:msg] += ' لم يتم ايجاد اسعار بعض المنتجات، قد يكون السبب اختلاف التسمية. '
            end
            lowest = price if i == 0 || lowest  > price
            highest = price if i == 0 || highest  < price
            product.set_price(market.id, price)
            product.set_url(market.id, url)
          end

          product.lowest_price = lowest
          product.highest_price = highest
          
          # Set Category
          product.category = Category.find_by(name_in_file: row['category']) if row['category']
          
          # Save changes
          product.save

          msg[status[:alert]] = status[:msg]
        # rescue => ex
        #   msg = { alert: ex.message }
        # end
      end
    rescue CSV::MalformedCSVError
      msg['danger'] = "لم يتم اضافة المنتجات لوجود صيغه لا يمكن التعرف عليها" 
    end
  
    redirect_to admin_new_upload_path, flash: msg
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        market_prices = params[:product][:market_price]
        market_prices.each do |market_id, value|
          @product.set_price(market_id, value)
        end
        market_urls = params[:product][:market_url]
        market_urls.each do |market_id, value|
          @product.set_url(market_id, value.empty? ? nil : value)
        end
        format.html { redirect_to admin_product_path(@product), notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: admin_product_path(@product) }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @product.update(product_params)
    respond_to do |format|
      if @product.update(product_params)
        prices = params[:product][:market_price]
        prices.each do |market_id, price|
          @product.set_price(market_id, price)
        end
        market_urls = params[:product][:market_url]
        market_urls.each do |market_id, value|
          @product.set_url(market_id, value.empty? ? nil : value)
        end
        format.html { redirect_to admin_product_path(@product), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_product_path(@product) }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to admin_products_path, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def error_uploading msg
      redirect_to admin_new_upload_path, flash: [alert: msg]
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :name_en, :description, :main_image, :category_id)
    end
end
