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
      buy: true,
      sell: true,
      price: @stock.price,
      quantity: params[:buy_transaction][:quantity]
      #[:name of form],[:field quantity]
    )

    # working
    # @user = current_user
    # @user.credit -= @stock.price
    # @user.save!

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