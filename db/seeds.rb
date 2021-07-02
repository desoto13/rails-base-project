# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = Admin.create(email: "admin@email.com", password: "qwerty", type: "Admin", username: "admin" , approved: true)
broker = Broker.create(email: "jc@email.com", password: "123123", type: "Broker", username: "jc" , approved: true)
buyer = Buyer.create(email: "jc2@email.com", password: "123123", type: "Buyer", username: "jc2" , approved: true)

client = IEX::Api::Client.new()

symbols = client.ref_data_symbols()
symbols.shuffle.slice(0,20).each do |symbol|
    quote = client.quote(symbol.symbol)
    company = client.company(symbol.symbol)

    new_stock = Stock.new
    new_stock.symbol = symbol.symbol
    new_stock.price = quote.latest_price
    new_stock.info = "#{company.company_name} - #{company.description}"
    new_stock.save
end