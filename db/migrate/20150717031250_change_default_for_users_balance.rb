class ChangeDefaultForUsersBalance < ActiveRecord::Migration
  def change
    # changing(updating) column to users table, balance column, decimal data type, adding default 0.0
    change_column :users, :balance, :decimal, default: 0.0
  end
end
