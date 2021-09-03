class Users::DashboardController < ApplicationController
  def index
    client = IEX::Api::Client.new(
      publishable_token: 'pk_1e6046c067f94660afa2f03aa72d47f1',
      endpoint: 'https://cloud.iexapis.com/v1'
    )
    @msft_stock = client.quote('MSFT').latest_price
    msft = client.company('MSFT')
    @msft_ceo = msft.ceo
    @msft_name = msft.company_name

    @fb_stock = client.quote('FB').latest_price
    fb = client.company('FB')
    @fb_ceo = fb.ceo
    @fb_name = fb.company_name

    @twtr_stock = client.quote('TWTR').latest_price
    twtr = client.company('TWTR')
    @twtr_ceo = twtr.ceo
    @twtr_name = twtr.company_name
  end
end
