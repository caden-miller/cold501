# frozen_string_literal: true

# Revise the Merch table by removing the stock column
class RemoveStockFromMerch < ActiveRecord::Migration[7.0]
  def change
    remove_column :merches, :stock, :integer
  end
end
