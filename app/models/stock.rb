class Stock < ApplicationRecord
# you can access Stock.iex in the controller
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