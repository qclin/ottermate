class ChangeReviewColumnName < ActiveRecord::Migration
  def change
    rename_column :reviews, :review, :comment
  end
end
