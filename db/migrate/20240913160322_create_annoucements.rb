# frozen_string_literal: true

# CreateAnnoucements
class CreateAnnoucements < ActiveRecord::Migration[7.0]
  def change
    create_table :annoucements do |t|
      t.string :title
      t.text :description
      t.integer :created_by

      t.timestamps
    end
  end
end
