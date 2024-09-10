class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :image
      t.string :email
      t.string :password
      t.string :role
      t.string :committee
      t.integer :points
      t.string :uid
      t.text :token
      t.string :provider

      t.timestamps
    end
  end
end
