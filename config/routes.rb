Rails.application.routes.draw do
  devise_for :admins
  # Language wrapper
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    # "/en" OR "/ar"
    get "/", to: "user/pages#home", as: "home"
    
    # User Routes "/user"
    get "pages", to: "user/pages#home"
    get "pages/home", to: "user/pages#home"

    # Set user session
    get "/set_user", to: "user/pages#set_user", as: "set_user"

    # Add to cart
    # POST "/add_to_cart/:id"
    post "add_to_cart", to: "user/pages#add_to_cart", as: "add_to_cart"
    # Remove from cart
    # POST "/remove_from_cart/:id"
    post "remove_from_cart", to: "user/pages#remove_from_cart", as: "remove_from_cart"
    # Increment quantity
    # POST "/increment_quantity/:id"
    post "increment_quantity", to: "user/pages#increment_quantity", as: "increment_quantity"
    # decrement quantity
    # POST "/decrement_quantity/:id"
    post "decrement_quantity", to: "user/pages#decrement_quantity", as: "decrement_quantity"
    # Checkout (generate bill)
    # POST "/checkout"
    post "checkout", to: "user/pages#checkout", as: "checkout"

    get "generate_invoice",  to: "user/pages#generate_invoice", as: "generate_invoice"


    # Admin Routes "/admin"
    namespace :admin do
      # Market routes 
      # GET "/markets", GET "/markets/:id"
      # PUT "/markets/:id", POST "/markets", DELETE "/markets/:id"
      resources :markets

      # GET "/categories", GET "/categories/:id"
      # PUT "/categories/:id", POST "/categories", DELETE "/categories/:id"
      resources :categories

      # Upload product routes
      # GET "/products/new_upload"
      get "products/new_upload", to: "products#new_upload", as: "new_upload"
      # POST "/products/new_upload"
      post "products/upload_products", to: "products#upload_products", as: "upload_products"
      # GET "/products", GET "/products/:id"
      # PUT "/products/:id", POST "/products", DELETE "/products/:id"
      resources :products

      # Orders Routes
      # GET "/orders"
      get "orders", to: "orders#index", as: "orders"
      # GET "/order/:id"
      get "order/:id", to: "orders#show", as: "order"
      # DELETE "order/:id"
      delete "order/:id", to: "orders#destroy", as: "destroy_order"
      # GET "/invoice/:id"
      get "invoice/:id", to: "orders#view_invoice", as: "invoice"
      # POST "/generate_invoice/:order_id"
      post "invoice/:id", to: "orders#generate_invoice", as: "generate_invoice"

      # Users Routes
      # GET "/users"
      resources :users, only: [:index, :show, :edit, :update]

      # Settings Routes
      # GET "/settings"
      get "settings", to: "settings#index", as: "settings"
      # POST "/change_settings"
      post "change_settings", to: "settings#change_settings", as: "change_settings"
      
      # Admin Landing page "/admin"
      get "/", to: "pages#main"
      get "pages/main"
      # No route match
      # TODO: create a route for undefined routes for admins
    end

    # No routes match
    get "*path", to: "user/pages#no_match", as: "no_match"
  end
  
  # Root "/"
  root "user/pages#home"
  get "*path", to: redirect("/#{I18n.locale}/%{path}")
end
