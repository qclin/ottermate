class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :description
      t.integer :price
      t.string :photo_url
      t.string :neighborhood
      t.boolean :petfriendly

      t.timestamps null: false
    end
  end
end
