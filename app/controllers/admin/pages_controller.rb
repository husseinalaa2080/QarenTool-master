class Admin::PagesController < AdminController
  def main


    ##########################users to number of orders ####################################################
    @compeleted_orders = Order.where(confirmed: true).count 
    @not_compeleted_orders = Order.where(confirmed: false).count 
    @total_orders = Order.all.count 





    ########
    @popular_products= OrderProduct.select("order_products.id,products.name,order_products.order_id,sum(order_products.quantity) as quantity_orders ,count(*) as thecount")
    .left_joins(:product)
    .group("order_products.product_id,order_products.id,products.name").order('quantity_orders desc')

    @popular_products_name = @popular_products.collect(&:name)
    @popular_products_quantity = @popular_products.collect(&:quantity_orders)
    @most_ordered_products = 
    {
      labels: @popular_products_name,
       datasets: [
         {
             label: "اكثر المنتجات المطلوبة",
             backgroundColor: "rgb(4,115,4)",
             borderColor: "rgb(4,115,4)",
             data: @popular_products_quantity
         }
         
       ]
     }
    #######
    @o_users= Order.select("orders.id,orders.user_id,users.name as user_name,orders.confirmed_by, avg(order_price) as average_price,sum(order_price) as sum_price ,count(*) as purchase")
    .left_joins(:user).group("orders.user_id,orders.id,users.name")
    @orders_count = @o_users.collect(&:purchase)
    @users_count = @o_users.collect(&:user_name)
    #################################################################################
    @sum_price = @o_users.collect(&:sum_price)
    #######################################################
    ########################################################################################

    ######################  orders #########################################################
     ################################# daily ###################################### 
     report_daily = Order.get_report('daily')
     @count_per_day = report_daily["count"]
     @o_time_daily =  report_daily["o_time"]
     ######################## monthly ##################################
     report_monthly = Order.get_report('monthly')
     @count_per_month = report_monthly["count"]
      @o_time_monthly =  report_monthly["o_time"]
      ################ yearly#######################################
      report_yearly = Order.get_report('yearly')
     @count_per_year = report_yearly["count"]
      @o_time_yearly =  report_yearly["o_time"]
      ###################################################################


      ###################average orders #############################################
      ######################daily#####################################################
      @average_order_daily =  report_daily["average_order_price"]
      @max_order_daily =  report_daily["max_price"]
      @min_order_daily =  report_daily["min_price"]

     @average_order_monthly =  report_monthly["average_order_price"]
     @max_order_monthly =  report_monthly["max_price"]
     @min_order_monthly =  report_monthly["min_price"]

     @average_order_yearly =  report_yearly["average_order_price"]
     @max_order_yearly =  report_yearly["max_price"]
     @min_order_yearly =  report_yearly["min_price"]

     @options = {}

      ###############################################################################
  end
end
