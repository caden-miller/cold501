# frozen_string_literal: true

# CreateIdeas
class CreateIdeas < ActiveRecord::Migration[7.0]
  def change
    create_table :ideas do |t|
      t.string :title, null: false
      t.string :description
      t.integer :created_by

      t.timestamps
    end
  end
end
