class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :from_id
      t.integer :to_id
      t.string :msg
      t.boolean :read

      t.timestamps null: false
    end
  end
end
