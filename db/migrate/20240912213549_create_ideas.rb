class CreateIdeas < ActiveRecord::Migration[7.0]
  def change
    create_table :ideas do |t|
      t.string :title
      t.string :description
      t.integer :created_by
      t.datetime :created_at

      t.timestamps
    end
  end
end
