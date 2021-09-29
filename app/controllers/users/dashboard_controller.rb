class Users::DashboardController < ApplicationController
  # use @ to use it within the class

  def index
    # pulling of API data
    client = Stock.iex

    # query the database then update the stock prices
    Stock.all.each do |stock|
      stock.update!(price: client.quote(stock.name).latest_price)
    end

    @stocks = Stock.all

    # # looping through the transactions and getting the needed data in index
    # @transactions = current_user.transactions.all

    # getting the sum of the current user's per stock quantity
    @msft_stocks_owned = get_sum(current_user, Stock.find(1))
    @fb_stocks_owned = get_sum(current_user, Stock.find(2))
    @twtr_stocks_owned = get_sum(current_user, Stock.find(3))
  end

  def stockslist
    # pulling of API data
    client = Stock.iex

    # query the database then update the stock prices
    Stock.all.each do |stock|
      stock.update!(price: client.quote(stock.name).latest_price)
    end

    @stocks = Stock.all

    @msft_stocks_owned = get_sum(current_user, Stock.find(1))
    @fb_stocks_owned = get_sum(current_user, Stock.find(2))
    @twtr_stocks_owned = get_sum(current_user, Stock.find(3))
  end

  def transactions
    @transactions = current_user.transactions.all
    
    @msft_stocks_owned = get_sum(current_user, Stock.find(1))
    @fb_stocks_owned = get_sum(current_user, Stock.find(2))
    @twtr_stocks_owned = get_sum(current_user, Stock.find(3))
  end

  def new
    @transaction = Transaction.new
  end

  def buy
    # used for views
    @stock = Stock.find(params[:id])
  end

  def buy_transaction
    # method in form
    @stock = Stock.find(params[:id])

    # for transaction history tracking
    Transaction.create(
      user_id: current_user.id,
      stock_id: params[:id],
      stock_name: @stock.name,
      buy: true,
      sell: false,
      price: @stock.price,
      quantity: params[:buy_transaction][:quantity]
      # [:name of form],[:field quantity]
      # name of the form and what value you are getting
    )
    
    # basic math of deducting quantity from stock model and adding quantity for user model
    @transaction = current_user.transactions.last.quantity
    @user = current_user
    @user.credit -= (@stock.price * @transaction)
    @user.save!

    # update stock quantity
    @stock.quantity -= @transaction
    @stock.save!

    # same as redirect_to "/users/dashboard/index"
    redirect_to users_authenticated_root_path
  end

  def sell
    @stock = Stock.find(params[:id])
  end

  def sell_transaction
    @user = current_user
    @stock = Stock.find(params[:id])

    Transaction.create(
      user_id: current_user.id,
      stock_id: params[:id],
      stock_name: @stock.name,
      buy: false,
      sell: true,
      price: @stock.price,
      quantity: params[:sell_transaction][:quantity]
    )
    
    @sell_quantity = params[:sell_transaction][:quantity].to_f

    # add user credit
    @user.credit += (@stock.price * @sell_quantity)
    @user.save!

    # add stock quantity
    @stock.quantity += @sell_quantity
    @stock.save!

    redirect_to users_authenticated_root_path
  end

  private
  def transaction_params
    params.require(:transaction).permit(:quantity)
  end

  # processing the .sum(:quantity) of buy:true & sell:true
  def get_sum(current_user, stock)
    current_stock_sum = Transaction.where(user_id: current_user.id, stock_id: stock.id, buy: true).sum(:quantity)
    current_stock_diff = Transaction.where(user_id: current_user.id, stock_id: stock.id, sell: true).sum(:quantity)
    current_stock_sum -= current_stock_diff
   
    current_stock_sum
  end
end