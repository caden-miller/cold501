class CreateMerches < ActiveRecord::Migration[7.0]
  def change
    create_table :merches do |t|
      t.string :link
      t.string :title
      t.string :description
      t.string :image
      t.integer :stock

      t.timestamps
    end
  end
end
