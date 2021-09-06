class AddStockNameToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :stock_name, :string
  end
end
