class RmUserPriceCol < ActiveRecord::Migration
  def change
    remove_column :users, :price
  end
end
