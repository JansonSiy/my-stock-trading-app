class Users::DashboardController < ApplicationController
  # use @ to use it within the class

  def index
    client = Stock.iex

    # query the database then update the stock prices
    Stock.all.each do |stock|
      stock.update!(price: client.quote(stock.name).latest_price)
    end

    @stocks = Stock.all

    @transactions = current_user.transactions.all

    @msft_stocks_owned = Transaction.where(user_id:current_user.id, stock_id:1, buy: true).sum(:quantity)

    @fb_stocks_owned = Transaction.where(user_id:current_user.id, stock_id:2, buy: true).sum(:quantity)

    @twtr_stocks_owned = Transaction.where(user_id:current_user.id, stock_id:2, buy: true).sum(:quantity)
  end

  def new
    @transaction = Transaction.new
  end

  def buy
    @stock = Stock.find(params[:id])
  end

  def buy_transaction
    @stock = Stock.find(params[:id])

    Transaction.create(
      user_id: current_user.id,
      stock_id: params[:id],
      stock_name: @stock.name,
      buy: true,
      sell: false,
      price: @stock.price,
      quantity: params[:buy_transaction][:quantity]
      #[:name of form],[:field quantity]
    )
    
    @transaction = current_user.transactions.last.quantity
    @user = current_user
    @user.credit -= (@stock.price * @transaction)
    @user.save!

    @stock.quantity -= @transaction
    @stock.save!

    # same as redirect_to "/users/dashboard/index"
    redirect_to users_authenticated_root_path
  end

  def sell
    @stock = Stock.find(params[:id])
  end

  private
  def transaction_params
    params.require(:transaction).permit(:quantity)
  end
end