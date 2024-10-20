# frozen_string_literal: true

class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :title
      t.string :link

      t.timestamps
    end
  end
end
