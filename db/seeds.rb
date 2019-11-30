# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AdminSetting.destroy_all
AdminSetting.create(allow_registration: true)


Admin.find_by_or_create!(email: 'khalidkhalil1993@outlook.com',password: '123456',
password_confirmation: '123456')

10.times do 
    Category.create!(name: Faker::Commerce.department,
    name_en: Faker::Commerce.department,
    description: Faker::Commerce.material)
end
50.times do 
Product.create!(name: Faker::Commerce.product_name,
name_en: Faker::Commerce.product_name,
description: Faker::Commerce.department,
category_id: Faker::Number.within(range: 1..10),
lowest_price: Faker::Number.within(range: 1..10),
highest_price: Faker::Number.within(range: 30..50)

 )

end

50.times do 
u = User.first 
Order.create!(user_id: u.id,order_price: Faker::Number.within(range: 10..500),
confirmed: Faker::Boolean.boolean,confirmed_by: 1,
checkout_at: Faker::Time.between(from: DateTime.now - 6, to: DateTime.now),
confirmed_at: Faker::Time.between(from: DateTime.now - 14, to: DateTime.now - 7 ),
created_at: Faker::Time.between(from: DateTime.now - 14, to: DateTime.now - 7 ))
end


50.times do 
    u = User.last 
    Order.create!(user_id: u.id,order_price: Faker::Number.within(range: 10..500),
    confirmed: Faker::Boolean.boolean,confirmed_by: 1,
    checkout_at: Faker::Time.between(from: DateTime.now - 6, to: DateTime.now),
    confirmed_at: Faker::Time.between(from: DateTime.now - 14, to: DateTime.now - 7 ),
    created_at: Faker::Time.between(from: DateTime.now , to: DateTime.now + 100 )) #till three months 
end