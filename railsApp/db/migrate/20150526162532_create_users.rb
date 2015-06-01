class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :price
      t.string :gender
      t.string :hasRoom
      t.string :personality
      t.string :occupation
      t.string :email
      t.string :phone

      t.timestamps null: false
    end
  end
end
