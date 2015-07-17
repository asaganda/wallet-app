class ChangeTypeColumnForCards < ActiveRecord::Migration
  def change
    # renaming the column named type to card_type; cards table, old column name, new column name
    rename_column :cards, :type, :card_type
  end
end
