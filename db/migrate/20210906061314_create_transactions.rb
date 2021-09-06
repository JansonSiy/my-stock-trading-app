class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.bigint :user_id
      t.bigint :stock_id
      t.boolean :buy
      t.boolean :sell
      t.decimal :price
      t.decimal :quantity

      t.timestamps
    end
  end
end
