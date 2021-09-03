class StocksController < ApplicationController
  before_action :set_stock, only: %i[ show edit update destroy ]

  # Publishable API tokens are meant solely to identify your account with IEX Cloud, they aren’t secret.
  # They can be published in places like your website JavaScript code, or in an iPhone or Android app.

  # Secret API tokens should be kept confidential and only stored on your own servers.
  # Your account’s secret API token can perform any API request to IEX Cloud.

    # To use any IEX Cloud API, you must pass an API token with each request.
    # def iex_api
    #   IEX::Api::Client.new(
    #     publishable_token: pk_1e6046c067f94660afa2f03aa72d47f1,
    #     secret_token: sk_35968cc025d645d5910bd445b2cd145f,
    #     endpoint: 'https://cloud.iexapis.com/v1'
    #   )
    # end

    # IEX Cloud provides all accounts a free, unlimited use sandbox for testing.
    # def sandbox_api
    #   IEX::Api::Client.new(
    #     publishable_token: Tpk_00513307abff4551a5e7240c1f0a8492,
    #     secret_token: Tsk_d4c84d8f05e34ae2a34cb0d5f1805b60,
    #     endpoint: 'https://cloud.iexapis.com/v1'
    #   )
    # end

  def index
    client = IEX::Api::Client.new(
      publishable_token: 'pk_1e6046c067f94660afa2f03aa72d47f1',
      endpoint: 'https://cloud.iexapis.com/v1'
    )
    @stock = client.quote('msft').latest_price
  end

  # GET /stocks or /stocks.json
  # def index
  #   @stocks = Stock.all
  # end

  # GET /stocks/1 or /stocks/1.json
  def show
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks or /stocks.json
  def create
    @stock = Stock.new(stock_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: "Stock was successfully created." }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1 or /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: "Stock was successfully updated." }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1 or /stocks/1.json
  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stock_params
      params.require(:stock).permit(:name)
    end
end