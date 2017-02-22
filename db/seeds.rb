# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = Category.create([
                               {title: 'Auto'},
                               {title: 'Wear'},
                               {title: 'Real estate'},
                               {title: 'Sport inventory'},
                              ])

users = User.create([
                       {email: 'user@gmail.com', password: '11111111', role: 'user'},
                       {email: 'admin@gmail.com', password: 'admin123', role: 'admin'}])

adverts = Advert.create([
                           {title: 'Auto', description: 'Fast car.', price: '45000', user_id: 1, category_id: 1},
                           {title: 'Glasses', description: 'This Ray-Ban 5184 is the slimmer and sleeker version of the classic wayfarer. Constructed from high-grade plastic, its bulky arms and signature metal accents provide you with a sense of purpose and style.', 
                            price: '159', user_id: 2, category_id: 2}])