class AddApprovedToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :approved, :boolean, :default => false, :null => false
    # added a column in "user", named "approved", type is "boolean" in database
    add_index  :users, :approved
    # allows access to the initial values declared above ":default => false, :null => false"
  end
end