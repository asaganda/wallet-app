class AddPasswordToUsers < ActiveRecord::Migration
  def change
    # adding column to users table, password is the name of the column, text data type
    add_column :users, :password, :text
  end
end
