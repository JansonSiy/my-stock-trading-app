class Stock < ApplicationRecord
# you can access Stock.iex in the controller
  def self.iex
    client = IEX::Api::Client.new(
      publishable_token: 'pk_1e6046c067f94660afa2f03aa72d47f1',
      endpoint: 'https://cloud.iexapis.com/v1'
    )
  end

  def self.sandbox
    client = IEX::Api::Client.new(
      publishable_token: 'Tpk_00513307abff4551a5e7240c1f0a8492',
      endpoint: 'https://cloud.iexapis.com/v1'
    )
  end
end