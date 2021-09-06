class AddQuantityToStocks < ActiveRecord::Migration[6.1]
  def change
    add_column :stocks, :quantity, :decimal
  end
end
