# frozen_string_literal: true

# CreateMerchandises
class CreateMerchandises < ActiveRecord::Migration[7.0]
  def change
    create_table :merchandises do |t|
      t.string :link
      t.string :title
      t.string :description
      t.string :image
      t.integer :stock

      t.timestamps
    end
  end
end
