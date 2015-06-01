class UpdateUserData < ActiveRecord::Migration
  def change
    add_column :users, :description, :string
    add_column :users, :reliability, :float
    add_column :users, :watsonfeed, :string
  end
end
