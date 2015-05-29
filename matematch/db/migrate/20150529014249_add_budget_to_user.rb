class AddBudgetToUser < ActiveRecord::Migration
  def change
    add_column :users, :budget, :integer 
  end
end
