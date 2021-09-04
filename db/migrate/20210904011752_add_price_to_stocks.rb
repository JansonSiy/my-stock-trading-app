class AddPriceToStocks < ActiveRecord::Migration[6.1]
  def change
    add_column :stocks, :price, :decimal
  end
end
