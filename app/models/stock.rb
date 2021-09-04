class Stock < ApplicationRecord
  # Pag walang self, maaaccess si iex gamit ng: 
  # stock = Stock.new
  # stock = stock.iex

  # Pag may self, maaaccess si iex gamit ng: 
  # Stock.iex
  def self.iex
    client = IEX::Api::Client.new(
      publishable_token: ENV['iex_publishable_token'],
      endpoint: 'https://cloud.iexapis.com/v1'
    )
  end

  def self.sandbox
    client = IEX::Api::Client.new(
      publishable_token: ENV['sandbox_publishable_token'],
      endpoint: 'https://cloud.iexapis.com/v1'
    )
  end
end