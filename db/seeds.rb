# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = Admin.create(id: 1, email: "admin@email.com", password: "qwerty", type: "Admin", username: "admin" , approved: true)
broker = Broker.create(id: 2, email:"jc@email.com", password: "123456", type: "Broker", username: "jc", approved: true)
buyer = Buyer.create(id: 3, email:"jc2@email.com", password: "123456", type: "Buyer", username: "jc2", approved: true)
stock1 = Stock.create(id: 1, symbol: "FB", price: 34.5, info: "facebook")
stock2 = Stock.create(id: 2, symbol: "AMZ", price: 34.5, info: "Amazon")
stock3 = Stock.create(id: 3, symbol: "MSFT", price: 34.5, info: "Microsoft")