class ChangeDataType < ActiveRecord::Migration
   def up 
    change_table :users do |t|
      t.change :price, :integer
      t.change :hasRoom, :boolean
      t.change :phone, :integer
    end 
  end 

  def down
    change_table :users do |t|
      t.change :price, :string
      t.change :hasRoom, :string
      t.change :phone, :string
    end 
  end 

end
