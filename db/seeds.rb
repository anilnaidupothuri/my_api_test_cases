# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times do 
	user = User.create(email: Faker::Internet.email, password:'123456', name:Faker::Name.name, 
		                location: Faker::Address.city)

  2.times do 
  	 product=Product.create(title: Faker::Commerce.product_name,
  	 	                    price: rand(100..1000),
  	 	                    published: true,
  	 	                    user_id: user.id)
  	end
  end