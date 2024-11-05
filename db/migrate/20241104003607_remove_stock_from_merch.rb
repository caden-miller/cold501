class RemoveStockFromMerch < ActiveRecord::Migration[7.0]
  def change
    remove_column :merches, :stock, :integer
  end
end
