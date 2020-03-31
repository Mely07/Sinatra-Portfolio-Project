class CreateGroceries < ActiveRecord::Migration
  def change
    create_table :groceries do |t|
      t.string :name
      t.string :brand 
      t.date :expiration_date 
      t.integer :user_id
    end
  end
end
