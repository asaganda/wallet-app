class AddExpirationDateToCard < ActiveRecord::Migration
  def change
    # adding column to users table, expiration_date is the name of the column, datetime data type
    add_column :cards, :expiration_date, :datetime
  end
end
