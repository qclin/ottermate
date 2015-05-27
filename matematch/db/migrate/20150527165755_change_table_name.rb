class ChangeTableName < ActiveRecord::Migration
  def change
    rename_table :user_endorsements, :endorsements
    rename_table :room_reviews, :reviews
  end
end
