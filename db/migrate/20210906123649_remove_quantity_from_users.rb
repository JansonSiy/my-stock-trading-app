class RemoveQuantityFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :quantity, :decimal
  end
end
