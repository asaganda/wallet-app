class AddPhoneColumnToUsers < ActiveRecord::Migration
  def change
    # adding column to users table, phone is the name of the column, string data type
    add_column :users, :phone, :string
  end
end
