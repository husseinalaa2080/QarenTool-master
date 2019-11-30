json.extract! product, :id, :name, :name_en, :description, :main_image, :category_id, :created_at, :updated_at
json.url product_url(product, format: :json)
