class Users::DashboardController < ApplicationController
  # use @ to use it within the class

  def index
    client = Stock.iex
    # Stock nag ququery sa database
    Stock.all.each do |stock|
      stock.update!(price: client.quote(stock.name).latest_price)
    end
    @stocks = Stock.all
  end
end