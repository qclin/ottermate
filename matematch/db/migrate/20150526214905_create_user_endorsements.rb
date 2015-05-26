class CreateUserEndorsements < ActiveRecord::Migration
  def change
    create_table :user_endorsements do |t|
      t.integer :endorser_id
      t.integer :endorsee_id
      t.string :skill

      t.timestamps null: false
    end
  end
end
