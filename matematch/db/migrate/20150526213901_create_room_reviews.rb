class CreateRoomReviews < ActiveRecord::Migration
  def change
    create_table :room_reviews do |t|
      t.integer :room_id
      t.integer :reviewer_id
      t.string :review

      t.timestamps null: false
    end
  end
end
