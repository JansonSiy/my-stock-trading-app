# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.destroy_all
Admin.create(email: "admin@email.com", password: "adminadmin")

User.destroy_all
User.create(id: 1, email: "jansonsiy@email.com", password: "jansonsiy", approved: true, role: "Buyer", credit: 100)
User.create(id: 2, email: "nikkagoot@email.com", password: "nikkagoot", approved: false, role: "Broker", credit: 200)

Stock.destroy_all
@client = Stock.iex
# same as the below
# client = IEX::Api::Client.new(
#   publishable_token: 'pk_1e6046c067f94660afa2f03aa72d47f1',
#   endpoint: 'https://cloud.iexapis.com/v1'
# )
msft_stock_price = @client.quote('MSFT').latest_price
Stock.create(name: 'MSFT', price: msft_stock_price, quantity: 1000)

fb_stock_price = @client.quote('FB').latest_price
Stock.create(name: 'FB', price: fb_stock_price, quantity: 1000)

twtr_stock_price = @client.quote('TWTR').latest_price
Stock.create(name: 'TWTR', price: twtr_stock_price, quantity: 1000)