class ImageAttachment < ActiveRecord::Migration
  def change
    add_attachment :rooms, :image
  end
end
